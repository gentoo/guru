# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake java-pkg-opt-2

DESCRIPTION="JPEG XL image format reference implementation"
HOMEPAGE="https://github.com/libjxl/libjxl"
SRC_URI="https://github.com/libjxl/libjxl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="abi_x86_64 cpu_flags_arm_neon benchmark devtools examples java man +openexr plugins profile +sjpeg +skcms tcmalloc tools viewers" #emscripten fuzzers

CDEPEND="
	app-arch/brotli
	dev-cpp/highway:=
	media-libs/libpng
	media-libs/lodepng:=
	media-libs/giflib
	sys-libs/zlib

	benchmark? (
		media-libs/libavif
		media-libs/libwebp
		virtual/jpeg
	)
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
	viewers? (
		dev-qt/qtconcurrent
		dev-qt/qtwidgets
		dev-qt/qtx11extras
		media-libs/lcms
		x11-libs/libxcb
	)
"
RDEPEND="
	${CDEPEND}
	java? ( virtual/jre:1.8 )
"
DEPEND="
	${CDEPEND}
	dev-cpp/gtest
	kde-frameworks/extra-cmake-modules
	java? ( virtual/jdk:1.8 )
	plugins? ( x11-misc/xdg-utils )
"
BDEPEND="
	virtual/pkgconfig
	man? ( app-text/asciidoc )
"

PATCHES=( "${FILESDIR}/${P}-system-libs.patch" )
REQUIRED_USE="tcmalloc? ( abi_x86_64 )"
DOCS=( AUTHORS README.md SECURITY.md PATENTS CONTRIBUTORS CHANGELOG.md )

CMAKE_IN_SOURCE_BUILD=1

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
		-DJPEGXL_ENABLE_JNI=$(usex java)
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
	einstalldocs
	#TODO: install documentation
	exeinto "/usr/libexec/${PN}"
	if use examples; then
		doexe {en,de}code_oneshot
		dobin jxlinfo
	fi
	pushd "${BUILD_DIR}/tools" || die
	insinto "/usr/share/${PN}"
	doins progressive_saliency.conf example_tree.txt
	if use java; then
		dolib.so libjxl_jni.so
		rm libjxl_jni.so || die
		doins *.jar
	fi
	if use benchmark; then
		docinto "/usr/share/doc/${PF}/benchmark/hm"
		dodoc benchmark/hm/README.md
	else
		rm -r benchmark || die
	fi
	# remove non executable or non .m files
	find . -type f \! -name '*.m' \! -executable -delete || die
	# delete empty dirs
	find . -type d -empty -print -delete || die
	mkdir -p "${ED}/usr/libexec/${PN}/tools/" || die
	# install tools
	cp -r . "${ED}/usr/libexec/${PN}/tools/" || die

	# keep in /usr/bin only the executables with jxl in the name
	rm -f "${ED}"/usr/libexec/${PN}/tools/*jxl* || die
	rm -f "${ED}"/usr/bin{fuzzer_corpus,*_main,decode_and_encode,*_hlg,tone_map,xyb_range} || die

	find "${D}" -name '*.a' -delete || die
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
