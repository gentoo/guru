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
	dev-libs/KVTree[mpi]
	dev-libs/shuffile
	sys-cluster/redset
	sys-libs/zlib
	virtual/mpi
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-no-static.patch" )
RESTRICT="!test? ( test )"

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_TESTS=$(usex test)
		-DER_LINK_STATIC=OFF
	)
	cmake_src_configure
}
