# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SHUFFILE Shuffle files between processes"
HOMEPAGE="https://github.com/ECP-VeloC/shuffile"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	>=dev-libs/KVTree-1.0.2[mpi]
	sys-libs/zlib
	virtual/mpi
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-no-static.patch" )
# tests require access to /dev/shm, thus root permission is needed
# but mpirun refuse to run as root
RESTRICT="test"

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_TESTS=$(usex test)
		-DSHUFFILE_LINK_STATIC=OFF
	)
	cmake_src_configure
}

src_test() {
	if mountpoint -q /dev/shm ; then
		cmake_src_test
	else
		eerror "make sure to mount /dev/shm or tests will fail"
		die
	fi
}
