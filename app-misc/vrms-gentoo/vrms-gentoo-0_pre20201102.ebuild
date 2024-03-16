# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="4fd604c4816d620be3cf9c5e9dd578b2c30c21bc"

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
