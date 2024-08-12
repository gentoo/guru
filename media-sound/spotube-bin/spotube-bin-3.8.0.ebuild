# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MyPN="spotube"

DESCRIPTION="An open source, cross-platform Spotify client"
HOMEPAGE="https://spotube.krtirtho.dev/"

RDEPEND="
	>=media-video/mpv-0.38.0-r1
"

SRC_URI="https://github.com/KRTirtho/${MyPN}/releases/download/v${PV}/${MyPN}-linux-${PV}-x86_64.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	sed -i '/\//s/Icon=\/usr\/share\/icons\/spotube\/spotube-logo.png/Icon=\/usr\/share\/pixmaps\/spotube-logo.png/' spotube.desktop
}

src_install() {
	insinto /opt/spotube
	doins -r data lib spotube
	fperms 775 /opt/spotube/spotube
	domenu spotube.desktop
	doicon spotube-logo.png
	dosym /opt/spotube/spotube /usr/bin/spotube
}
