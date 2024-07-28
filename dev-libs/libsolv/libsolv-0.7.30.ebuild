# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="https://github.com/openSUSE/libsolv"
SRC_URI="https://github.com/openSUSE/libsolv/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="expat test zchunk"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/bzip2
	app-arch/rpm
	app-arch/xz-utils
	app-arch/zstd:=
	sys-libs/zlib
	expat? ( dev-libs/expat )
	!expat? ( dev-libs/libxml2 )
	zchunk? ( app-arch/zchunk )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_COMPLEX_DEPS=ON
		-DENABLE_COMPS=ON
		-DENABLE_RPMDB=ON
		-DENABLE_RPMMD=ON
		-DENABLE_RPMPKG_LIBRPM=ON
		-DENABLE_BZIP2_COMPRESSION=ON
		-DENABLE_LZMA_COMPRESSION=ON
		-DENABLE_ZSTD_COMPRESSION=ON
		-DWITH_LIBXML2=$(usex !expat)
		-DWITH_SYSTEM_ZCHUNK=$(usex zchunk)
	)
	cmake_src_configure
}
