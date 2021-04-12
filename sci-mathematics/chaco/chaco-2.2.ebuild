# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Software for Partitioning Graphs"
HOMEPAGE="https://www3.cs.stonybrook.edu/~algorith/implement/chaco/implement.shtml"
SRC_URI="https://www3.cs.stonybrook.edu/~algorith/implement/${PN}/distrib/Chaco-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PATCHES=( "${FILESDIR}/makefile.patch" )
S="${WORKDIR}/Chaco-${PV}"

src_install() {
	pushd code || die
	emake
	popd || die
	dobin "exec/chaco"
	dodoc -r doc/.
}
