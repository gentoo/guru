# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="JPEG XL image format reference implementation"
HOMEPAGE="https://github.com/libjxl/libjxl"
SRC_URI="https://github.com/libjxl/libjxl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="abi_x86_64 cpu_flags_arm_neon benchmark devtools examples man +openexr plugins profile +sjpeg +skcms tcmalloc tools viewers" #java

RDEPEND="
	app-arch/brotli
	dev-cpp/highway:=
	media-libs/libpng
	media-libs/lodepng:=
	media-libs/giflib
	sys-libs/zlib
	virtual/jpeg

	openexr? ( media-libs/openexr:= )
	plugins? (
		dev-libs/glib:2
		media-gfx/gimp
		media-libs/babl
		media-libs/gegl
		media-libs/skcms:=
		x11-libs/gdk-pixbuf
		x11-misc/shared-mime-info
	)
	sjpeg? ( media-libs/sjpeg:= )
	!skcms? ( media-libs/lcms )
	skcms? ( media-libs/skcms:= )
	tcmalloc? ( dev-util/google-perftools )
	viewers? ( media-libs/lcms )
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
	plugins? ( x11-misc/xdg-utils )
"
BDEPEND="man? ( app-text/asciidoc )"

PATCHES=( "${FILESDIR}/${P}-system-libs.patch" )
REQUIRED_USE="tcmalloc? ( abi_x86_64 )"

src_prepare() {
	# remove bundled libs cmake
	rm third_party/*.cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DJPEGXL_ENABLE_BENCHMARK=$(usex benchmark)
		-DJPEGXL_ENABLE_DEVTOOLS=$(usex devtools)
		-DJPEGXL_ENABLE_EXAMPLES=$(usex examples)
		-DJPEGXL_ENABLE_MANPAGES=$(usex man)
		-DJPEGXL_ENABLE_OPENEXR=$(usex openexr)
		-DJPEGXL_ENABLE_PLUGINS=$(usex plugins)
		-DJPEGXL_ENABLE_PROFILER=$(usex profile)
		-DJPEGXL_ENABLE_SJPEG=$(usex sjpeg)
		-DJPEGXL_ENABLE_SKCMS=$(usex skcms)
		-DJPEGXL_ENABLE_TCMALLOC=$(usex tcmalloc)
		-DJPEGXL_ENABLE_TOOLS=$(usex tools)
		-DJPEGXL_ENABLE_VIEWERS=$(usex viewers)
		-DJPEGXL_FORCE_NEON=$(usex cpu_flags_arm_neon)

		-DBUILD_SHARED_LIBS=ON
		-DJPEGXL_BUNDLE_SKCMS=OFF
		-DJPEGXL_ENABLE_COVERAGE=OFF
		-DJPEGXL_ENABLE_FUZZERS=OFF
		-DJPEGXL_ENABLE_TRANSCODE_JPEG=ON
		-DJPEGXL_FORCE_SYSTEM_BROTLI=ON
		-DJPEGXL_FORCE_SYSTEM_GTEST=ON
		-DJPEGXL_FORCE_SYSTEM_HWY=ON
		-DJPEGXL_STATIC=OFF
		-DJPEGXL_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	find "${D}" -name '*.a' -delete || die
	#TODO: install documentation
}
