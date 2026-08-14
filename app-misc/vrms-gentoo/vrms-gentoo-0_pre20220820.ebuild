# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="6ee80b51b8eeac4e67d8fbe53008b5534273e521"

DESCRIPTION="vrms clone for Gentoo Linux"
HOMEPAGE="https://github.com/z411/vrms-gentoo"
SRC_URI="https://github.com/z411/vrms-gentoo/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/perl
"

src_install() {
	default

	dobin "${PN}"
}
