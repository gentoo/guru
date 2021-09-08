# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Software for Partitioning Graphs"
HOMEPAGE="https://www3.cs.stonybrook.edu/~algorith/implement/chaco/implement.shtml"
SRC_URI="https://www3.cs.stonybrook.edu/~algorith/implement/${PN}/distrib/Chaco-${PV}.tar.gz"
S="${WORKDIR}/Chaco-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PATCHES=(
	"${FILESDIR}/${P}-lib.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
	"${FILESDIR}/${P}-shared.patch"
)

src_compile() {
	cd code || die
	tc-export CC
	default
}

src_install() {
	dodoc -r doc/.
	insinto "/usr/share/octave/packages/${PN}"
	doins -r code/matlab/*
	cd "exec" || die
	dobin "chaco"
	dolib.so "libchaco.so"
	insinto "/usr/share/${PN}"
	doins *.coords *.graph "User_Params"
	newdoc README README_exec
}
