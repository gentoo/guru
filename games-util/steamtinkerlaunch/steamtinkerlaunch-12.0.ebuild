# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit optfeature xdg

DESCRIPTION="Wrapper script for Steam custom launch options"
HOMEPAGE="https://github.com/frostworx/steamtinkerlaunch"
SRC_URI="https://github.com/frostworx/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

DEPEND=

RDEPEND="
	app-arch/unzip
	|| ( app-editors/vim-core dev-util/xxd )
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xwininfo
	x11-misc/xdotool

	>=gnome-extra/yad-7.2
"

src_prepare() {
	default

	sed -e 's|PREFIX := /usr|PREFIX := $(DESTDIR)/usr|g' \
		-e "s|share/doc/${PN}|share/doc/${PF}|g" \
		-e '/sed "s:^PREFIX/d' \
		-i Makefile || die
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "writing an strace log of the launched game" dev-util/strace
	optfeature "using GameMode per game" games-util/gamemode
	optfeature "using MangoHUD per game" games-util/mangohud
	optfeature "using vkBasalt per game" games-util/vkbasalt
	optfeature "winetricks support" app-emulation/winetricks
	optfeature "playing regular games side-by-side in VR" media-gfx/vr-video-player
	optfeature "using Nyrna per game" x11-misc/nyrna
	optfeature "network monitoring" sys-apps/net-tools
	optfeature "Boxtron support" games-engines/boxtron
	optfeature "ScummVM support via Roberta" games-engines/scummvm
	optfeature "wine support" virtual/wine
	optfeature "GameScope support" games-util/gamescope
	optfeature "Notifier" x11-libs/libnotify
	optfeature "extracting the Cheat Engine setup archive" app-arch/innoextract
	optfeature "a quick VR HMD presence check" sys-apps/usbutils
	optfeature "extracting game names from the steam api" app-misc/jq
	optfeature "scaling a custom installed game header picture and for converting game icons" media-gfx/imagemagick
	optfeature "extracting SpecialK archives" app-arch/p7zip
}
