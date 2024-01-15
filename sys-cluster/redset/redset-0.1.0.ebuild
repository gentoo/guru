# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Low-level distributed erasure coding lib to protect datasets of MPI applications"
HOMEPAGE="https://github.com/ECP-VeloC/redset"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="slurm test"

RDEPEND="
	dev-libs/KVTree[mpi]
	sys-cluster/rankstr
	sys-libs/zlib
	virtual/mpi
"
DEPEND="
	${RDEPEND}
	test? (
		slurm? ( sys-cluster/slurm )
	)
"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${P}-no-static.patch" )

src_configure() {
	local resman="NONE"
	use slurm && resman="SLURM"
	export "VELOC_RESOURCE_MANAGER=${resman}"

	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DREDSET_LINK_STATIC=OFF
		-DENABLE_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc -r doc/rst/.
}
