# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="902f5e3cbba66833bbf2d219c183d4705b3582c7"

inherit cmake edos2unix

DESCRIPTION='Fast distributed sorting routines using MPI and OpenMP'
HOMEPAGE="https://github.com/hsundar/usort"
SRC_URI="https://github.com/hsundar/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE='MIT'
SLOT="0/${PV}"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
	"${FILESDIR}/${P}-rename-THRESHOLD.patch"
	"${FILESDIR}/${P}-fix-fpermissive.patch"
)

src_prepare() {
	edos2unix CMakeLists.txt include/{seqUtils.h,seqUtils.tcc,ompUtils.tcc}
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	dodoc README.md
}
