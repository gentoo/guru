# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Open Source An Anime Game launcher for Linux with automatic anti-cheat patching and telemetry disabling, binary package"
HOMEPAGE="https://gitlab.com/an-anime-team/an-anime-game-launcher"
SRC_URI="https://gitlab.com/an-anime-team/aagl-ebuilds/-/archive/${PV}/aagl-ebuilds-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	|| ( dev-libs/libayatana-appindicator dev-libs/libayatana-appindicator-bin ) \
	net-libs/webkit-gtk \
	dev-util/xdelta[lzma] \
	app-arch/tar \
	dev-vcs/git \
	app-arch/unzip \
	net-misc/curl \
	app-arch/cabextract \
	x11-libs/libnotify \
	sys-auth/polkit \
	dev-libs/libdbusmenu \
	app-emulation/dxvk-bin \
	app-emulation/winetricks \
	virtual/wine \
	"

RDEPEND="${DEPEND}"

BDEPEND="app-admin/chrpath"

S="${WORKDIR}/aagl-ebuilds-${PV}"
src_prepare(){
	mv "icon.png" "${PN}.png"
	mv "launcher.sh" "${PN}"
	./An_Anime_Game_Launcher.AppImage --appimage-extract || die "Extraction Failed"
	chrpath -d "squashfs-root/public/discord-rpc/discord-rpc" || die "Patching Library Failed"
	eapply_user
}

src_install(){
	insinto "/usr/lib/${PN}"
	doins "squashfs-root/resources.neu"
	exeinto "/usr/lib/${PN}"
	doexe "squashfs-root/an-anime-game-launcher"
	doins -r "squashfs-root/public"
	insinto "/usr/share/pixmaps"
	doins "${PN}.png"
	exeinto "/usr/bin"
	doexe "${PN}"
	insinto "/usr/share/applications/"
	doins "${PN}.desktop"
}

pkg_postinst() {
	xdg_desktop_database_update
}
pkg_postrm() {
	xdg_desktop_database_update
}
