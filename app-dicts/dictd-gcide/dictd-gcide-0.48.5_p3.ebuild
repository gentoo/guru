# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=dict-gcide
MY_PV=${PV%_p*}+nmu${PV#*_p}

DESCRIPTION="Collaborative International Dictionary of English (incl. Webster 1913) for dict"
HOMEPAGE="https://tracker.debian.org/pkg/dict-gcide"
SRC_URI="mirror://debian/pool/main/d/${MY_PN}/${MY_PN}_${MY_PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-text/dictd"
DEPEND="dev-libs/libmaa"
BDEPEND="
	${RDEPEND}
	app-alternatives/lex
	app-alternatives/yacc
"

src_compile() {
	emake -j1 db
}

src_install() {
	insinto /usr/share/dict
	doins gcide.dict.dz gcide.index
}
