# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module systemd xdg

DESCRIPTION="An implementation of the MPRIS protocol for MPD."
HOMEPAGE="https://github.com/natsukagami/mpd-mpris"
SRC_URI="https://github.com/natsukagami/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pastalian/distfiles/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-sound/mpd"

src_prepare() {
	default
	sed -i "s|/usr/local/bin|${EPREFIX}/usr/bin|" services/mpd-mpris || die
}

src_compile() {
	ego build -o "${PN}" cmd/mpd-mpris/*.go
}

src_install() {
	einstalldocs

	dobin "${PN}"
	domenu mpd-mpris.desktop
	systemd_douserunit services/mpd-mpris.service
	doinitd services/mpd-mpris
}
