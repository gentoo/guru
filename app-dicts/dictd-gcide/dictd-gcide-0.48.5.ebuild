# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

MY_PN=dict-gcide

DESCRIPTION="Collaborative International Dictionary of English (incl. Webster 1913) for dict"
HOMEPAGE="https://tracker.debian.org/pkg/dict-gcide"
SRC_URI="mirror://debian/pool/main/d/${MY_PN}/${MY_PN}_${PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=app-text/dictd-1.13.0-r3"
RDEPEND="
	${BDEPEND}
	!app-dicts/dictd-web1913
"

src_compile() {
	emake -j1 db
}

src_install() {
	insinto /usr/share/dict
	doins gcide.dict.dz gcide.index
}
