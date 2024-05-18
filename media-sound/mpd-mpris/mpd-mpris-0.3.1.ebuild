# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module

DESCRIPTION="An implementation of the MPRIS protocol for MPD."
HOMEPAGE="https://github.com/natsukagami/mpd-mpris"
SRC_URI="https://github.com/natsukagami/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gitlab.com/Sevz17/go-deps/-/raw/main/${P}-deps.tar.xz"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-sound/mpd"
DEPEND="${RDEPEND}"

src_compile() {
	ego build -v -o "${PN}" cmd/mpd-mpris/*.go
}

src_install() {
	local DOCS=( "LICENSE" "README.md" )
	einstalldocs

	dobin "${PN}"

	systemd_douserunit mpd-mpris.service
}
