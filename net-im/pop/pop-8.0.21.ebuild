# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="Screen sharing with multiplayer control, with voice"
HOMEPAGE="https://pop.com/home"
SRC_URI="https://download.pop.com/desktop-app/linux/${PV}/${PN}_${PV}_amd64.deb"

LICENSE="all-rights-reserved"
SLOT=0
RESTRICT="strip"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	rm -rf usr/share/doc/

	doins -r usr
	fperms +x /usr/bin/"${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update

	einfo "If you want to share your screen - some compositor is required, like compton :("
}
