# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="Low-level distributed erasure coding lib to protect datasets of MPI applications"
HOMEPAGE="https://github.com/ECP-VeloC/redset"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	sys-cluster/KVTree[mpi]
	sys-cluster/rankstr
	sys-libs/zlib
	virtual/mpi
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-2.8
"

RESTRICT="test" # https://github.com/ECP-VeloC/redset/issues/30
PATCHES=( "${FILESDIR}/no-static-${PV}.patch" )

src_install() {
	cmake_src_install
	dodoc -r doc/rst/.
}
