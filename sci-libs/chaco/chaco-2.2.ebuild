# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit flag-o-matic

DESCRIPTION="Software for Partitioning Graphs"
HOMEPAGE="https://www3.cs.stonybrook.edu/~algorith/implement/chaco/implement.shtml"
SRC_URI="https://www3.cs.stonybrook.edu/~algorith/implement/${PN}/distrib/Chaco-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/Chaco-${PV}"

src_prepare() {
	sed -i '/CC =/d' code/Makefile
	sed -i '/CFLAGS =/d' code/Makefile
	sed -i -e 's/-O2/${CFLAGS}/g' code/Makefile
	eapply_user
}

src_install() {
	append-cflags -fPIE
	cd code
	emake
	cd ..
	dobin exec/chaco
	dodoc doc/*
}
