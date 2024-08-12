# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="spotube"

inherit desktop xdg

DESCRIPTION="An open source, cross-platform Spotify client"
HOMEPAGE="https://spotube.krtirtho.dev/"

SRC_URI="
	https://github.com/KRTirtho/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux-${PV}-x86_64.tar.xz
	 -> ${P}.tar.xz
"
S="${WORKDIR}"

LICENSE="BSD-4"
SLOT="0"

KEYWORDS="~amd64"

BDEPEND="
	dev-util/patchelf
"
RDEPEND="
	>=media-video/mpv-0.38.0-r1
	>=dev-libs/libayatana-appindicator-0.5.92
"

src_prepare() {
	default

	sed -i '/^Icon=/s|=.*|=spotube-logo|' spotube.desktop || die
}

src_install() {
	insinto /opt/spotube
	doins -r data lib

	exeinto /opt/spotube
	doexe spotube
	domenu spotube.desktop
	doicon spotube-logo.png

	dodir /usr/bin
	dosym -r /opt/spotube/spotube /usr/bin/spotube

	patchelf --replace-needed "libappindicator3.so.1" "libayatana-appindicator3.so.1" "${ED}/opt/spotube/lib/libtray_manager_plugin.so" || die
}
