# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Simple host script (in Go) for simple web extension to open videos in mpv"
HOMEPAGE="https://github.com/Baldomo/open-in-mpv https://addons.mozilla.org/en-US/firefox/addon/iina-open-in-mpv"
SRC_URI="https://github.com/Baldomo/open-in-mpv/releases/download/v${PV}/linux.tar -> ${P}.tar"
S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/mpv
"

QA_PREBUILT='usr/bin/open-in-mpv'

src_install() {
	domenu open-in-mpv.desktop
	dobin open-in-mpv
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
