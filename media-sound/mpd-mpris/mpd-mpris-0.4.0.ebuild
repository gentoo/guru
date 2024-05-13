# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing systemd go-module

DESCRIPTION="An implementation of the MPRIS protocol for MPD."
HOMEPAGE="https://github.com/natsukagami/mpd-mpris"
SRC_URI="https://github.com/natsukagami/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gitlab.com/sevz17/go-deps/-/raw/main/${P}-deps.tar.xz"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-sound/mpd"
DEPEND="${RDEPEND}"

src_compile() {
	ego build -v -x -p "$(makeopts_jobs)" -o "${PN}" cmd/mpd-mpris/*.go
}

src_install() {
	einstalldocs

	dobin "${PN}"

	systemd_douserunit mpd-mpris.service
}
