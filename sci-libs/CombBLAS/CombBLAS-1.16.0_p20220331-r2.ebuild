# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="426f6be0b29831025cdcacc1f8f69e3520bfb0ff"

inherit cmake edos2unix

DESCRIPTION='The Combinatorial BLAS'
HOMEPAGE="https://github.com/PASSIONLab/CombBLAS"
SRC_URI="https://github.com/PASSIONLab/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE='BSD'
SLOT="0"

DEPEND="
	~sys-cluster/Graph500-1.2
	sys-cluster/psort
	sys-cluster/usort
	virtual/mpi
"
RDEPEND="${DEPEND}"

RESTRICT="test" # tests require an MPI setup
PATCHES=(
	"${FILESDIR}/${P}-rename-THRESHOLD.patch"
	"${FILESDIR}/${P}-psort.patch"
	"${FILESDIR}/${P}-cxx17.patch"
	"${FILESDIR}/${P}-system-libs.patch"
	"${FILESDIR}/${P}-GNUInstallDirs.patch"
	"${FILESDIR}/${P}-fix-matlab-addpath.patch"
)

src_prepare() {
	rm -r graph500-1.2 usort psort-1.0 || die
	edos2unix Matlab/startup.m
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	dodoc README.md FAQ.md CombBLASbinaryIO.docx
	insinto "/usr/include/CombBLAS/BipartiteMatchings"
	doins Applications/BipartiteMatchings/*.h
	insinto "/usr/share/octave/site/m/${PN}"
	doins -r Matlab/*
	insinto "/usr/share/doc/${PF}/html"
	doins *.html
}
