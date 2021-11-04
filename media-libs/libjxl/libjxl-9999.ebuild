# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit xdg cmake git-r3

DESCRIPTION="JPEG XL image format reference implementation"
HOMEPAGE="https://github.com/libjxl/libjxl"

EGIT_REPO_URI="https://github.com/libjxl/libjxl.git"

LICENSE="BSD"
SLOT="0"
IUSE="examples"

DEPEND="app-arch/brotli
	sys-libs/zlib
	media-libs/libpng
	virtual/jpeg
	virtual/opengl
	media-libs/freeglut
	media-libs/giflib
	media-libs/openexr:=
	dev-util/google-perftools
	x11-misc/shared-mime-info
	dev-cpp/gtest
	dev-cpp/highway
	media-libs/lcms
"

BDEPEND=""

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DJPEGXL_ENABLE_BENCHMARK=OFF
		-DJPEGXL_ENABLE_COVERAGE=OFF
		-DJPEGXL_ENABLE_FUZZERS=OFF
		-DJPEGXL_ENABLE_SJPEG=OFF
		-DJPEGXL_WARNINGS_AS_ERRORS=OFF

		-DJPEGXL_ENABLE_SKCMS=ON
		-DJPEGXL_ENABLE_EXAMPLES=$(usex examples)
		-DJPEGXL_ENABLE_VIEWERS=OFF
		-DJPEGXL_ENABLE_PLUGINS=ON
		-DJPEGXL_FORCE_SYSTEM_BROTLI=ON
		-DJPEGXL_FORCE_SYSTEM_HWY=ON
		-DJPEGXL_FORCE_SYSTEM_GTEST=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use examples; then
		dobin "${BUILD_DIR}/jxlinfo"
	fi
}
