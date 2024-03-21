# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Parallel sorting code for distributed and shared memory architectures"
HOMEPAGE="https://web.archive.org/web/20181126115900/http://gauss.cs.ucsb.edu/code/index.shtml"
SRC_URI="https://web.archive.org/web/20181126115900/http://gauss.cs.ucsb.edu/code/${PN}/${P}.tar.gz"

LICENSE="MIT GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-make_pair.patch"
	"${FILESDIR}/${P}-makefile.patch"
)

src_compile() {
	pushd driver || die
	emake
	popd || die
}

src_install() {
	dodoc README doc/psort.pdf
	insinto "/usr/include/psort"
	doins src/*.h driver/*.h
	dobin driver/psort
}
