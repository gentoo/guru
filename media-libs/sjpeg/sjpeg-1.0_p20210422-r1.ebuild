# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="676de227d75877eb5863ec805ba0a4b97fc2fc6c"

inherit cmake

DESCRIPTION="simple jpeg encoder"
HOMEPAGE="https://github.com/webmproject/sjpeg"
SRC_URI="https://github.com/webmproject/sjpeg/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_arm_neon cpu_flags_x86_sse2 +tools"

DEPEND="
	tools? (
		media-libs/libpng
		sys-libs/zlib
		virtual/jpeg
		virtual/opengl
	)
"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${PN}-rename-libutils.patch"
DOCS=( AUTHORS NEWS README README.md ChangeLog )

src_configure() {
	local mycmakeargs=(
		-DSJPEG_BUILD_EXAMPLES=$(usex tools)
	)

	if use cpu_flags_arm_neon || use cpu_flags_x86_sse2 ; then
		mycmakeargs+=( "-DSJPEG_ENABLE_SIMD=ON" )
	else
		mycmakeargs+=( "-DSJPEG_ENABLE_SIMD=OFF" )
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
	dolib.so "${BUILD_DIR}/libsjpeg-utils.so"
}
