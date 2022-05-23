# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MYPN="${PN,,}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Graph500 reference implementations"
HOMEPAGE="https://github.com/Graph500/graph500"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${MYP}.tar.gz"
S="${WORKDIR}/${MYPN}-${MYP}"

KEYWORDS="~amd64"
LICENSE="MIT Boost-1.0"
SLOT="0"
IUSE="mpi openmp"

RDEPEND="
	sys-libs/binutils-libs
	mpi? ( virtual/mpi )
"
DEPEND="${RDEPEND}"
BDEPEND="app-admin/chrpath"

PATCHES=(
	"${FILESDIR}/${P}-MPI_Type_create_struct.patch"
	"${FILESDIR}/${P}-static-inline.patch"
)

src_prepare() {
	cp "${FILESDIR}/${P}-CMakeLists.txt" CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_MPI=$(usex mpi)
		-DBUILD_OPENMP=$(usex openmp)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dosym ./libgenerator-seq.so "/usr/$(get_libdir)/libGraphGenlib.so"
	dodoc README Graph500.org
	insinto "/usr/share/doc/${PF}/html"
	doins *.html
	insinto "/usr/share/octave/site/m/${PN}"
	doins -r octave/*
	chrpath -d "${ED}/usr/bin/graph500_mpi_one_sided" || die
	chrpath -d "${ED}/usr/bin/graph500_mpi_simple" || die
	chrpath -d "${ED}/usr/bin/generator_test_mpi" || die
}
