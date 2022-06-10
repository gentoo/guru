# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="25f9621a8a983f0e4e85a694290ab9624dd2c2bc"

DESCRIPTION="FFS is a middleware library for data communication"
HOMEPAGE="https://github.com/GTkorvo/ffs"
SRC_URI="https://github.com/GTKorvo/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+atl test"

RDEPEND="
	atl? ( dev-libs/atl )
	dev-libs/dill
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

RESTRICT="test"
PROPERTIES="test_network"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DFFS_INSTALL_PKGCONFIG=ON
		-DFFS_INSTALL_HEADERS=ON
		-DFFS_QUIET=OFF

		-DFFS_USE_ATL=$(usex atl)
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
