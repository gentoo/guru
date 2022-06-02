# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="IMB-v${PV}"

DESCRIPTION="Intel MPI Benchmarks"
HOMEPAGE="
	https://www.intel.com/content/www/us/en/developer/articles/technical/intel-mpi-benchmarks.html
	https://github.com/intel/mpi-benchmarks
"
SRC_URI="https://github.com/intel/${PN}/archive/refs/tags/${MYP}.tar.gz"
S="${WORKDIR}/${PN}-${MYP}"

LICENSE="BSD CPL-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_install() {
	dodoc ReadMe_IMB.txt README.md
	dobin IMB-*
}
