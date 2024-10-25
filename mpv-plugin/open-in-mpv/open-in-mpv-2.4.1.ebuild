# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module desktop xdg

DESCRIPTION="Simple host script (in Go) for simple web extension to open videos in mpv"
HOMEPAGE="https://github.com/Baldomo/open-in-mpv https://addons.mozilla.org/en-US/firefox/addon/iina-open-in-mpv"
SRC_URI="https://github.com/Baldomo/open-in-mpv/releases/download/v${PV}/open-in-mpv_${PV}.tar.gz"
S="${WORKDIR}/${PN}_${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/mpv
	net-misc/yt-dlp
"

src_compile() {
	CGO_ENABLED=0 ego build -ldflags="-s -w -X main.Version=${PV}" -o ${PN} ./cmd/open-in-mpv/
}

src_test() {
	ego test ./...
}

src_install() {
	domenu scripts/open-in-mpv.desktop
	dobin ${PN}
}
