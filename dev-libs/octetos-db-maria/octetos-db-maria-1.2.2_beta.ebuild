# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="C++ library for Database Acces."
HOMEPAGE="https://github.com/azaeldevel/octetos-db"
SRC_URI="https://github.com/azaeldevel/octetos-db/archive/1.2.2-alpha.6.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-libs/octetos-core dev-db/mariadb-connector-c"
RDEPEND="${DEPEND}"
BDEPEND=""
src_unpack() {
	unpack ${A}
	ln -s octetos-db-1.2.2-alpha.6 $P
}
src_configure() {
	autoreconf -fi
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf --with-mariadb
	fi
}
src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake || die "emake failed"
	fi
}
