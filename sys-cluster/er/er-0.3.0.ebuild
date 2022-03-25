# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-level distributed erasure coding lib combining shuffile and redset"
HOMEPAGE="https://github.com/ECP-VeloC/er"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	sys-cluster/KVTree[mpi]
	sys-cluster/redset
	sys-cluster/shuffile
	virtual/mpi
"
DEPEND="
	${RDEPEND}
	test? ( sys-cluster/rankstr )
"

PATCHES=( "${FILESDIR}/${PN}-0.1.0-no-static.patch" )
RESTRICT="!test? ( test )"

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_TESTS=$(usex test)
		-DER_LINK_STATIC=OFF
	)
	cmake_src_configure
}
