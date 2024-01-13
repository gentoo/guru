# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fortran-2

DESCRIPTION="Library for reduced order models"
HOMEPAGE="
	https://www.librom.net/
	https://github.com/LLNL/libROM
"
SRC_URI="https://github.com/LLNL/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
IUSE="mfem"

RDEPEND="
	sci-libs/hdf5:=
	sci-libs/scalapack
	sys-libs/zlib
	virtual/blas
	virtual/lapack
	virtual/mpi[cxx]

	mfem? (
		sci-libs/hypre[mpi]
		sci-libs/metis
		sci-libs/mfem[mpi]
		sci-libs/parmetis
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="app-text/doxygen"

DOCS=( README.md CHANGELOG docs/libROM_Design_and_Theory.pdf )

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC=OFF
		-DUSE_MFEM=$(usex mfem)
	)
	cmake_src_configure
}

src_install() {
	insinto "/usr/include/${PN}"
	doins lib/*.h
	insinto "/usr/include/${PN}/utils"
	doins lib/utils/*.h
	insinto "/usr/include/${PN}/linalg"
	doins lib/linalg/*.h
	insinto "/usr/include/${PN}/linalg/svd"
	doins lib/linalg/svd/*.h
	insinto "/usr/include/${PN}/algo"
	doins lib/algo/*.h
	insinto "/usr/include/${PN}/algo/manifold_interp"
	doins lib/algo/manifold_interp/*.h
	insinto "/usr/include/${PN}/algo/greedy"
	doins lib/algo/greedy/*.h
	insinto "/usr/include/${PN}/hyperreduction"
	doins lib/hyperreduction/*.h
	insinto "/usr/include/${PN}/mfem"
	doins lib/mfem/*.hpp
	dolib.so "${BUILD_DIR}/lib/libROM.so"
	einstalldocs
	dodoc -r docs/html
}
