# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 optfeature

DESCRIPTION="Hyprshot is an utility to easily take screenshot in Hyprland using your mouse"
HOMEPAGE="https://github.com/Gustash/Hyprshot/"
EGIT_REPO_URI="https://github.com/Gustash/Hyprshot.git/"

LICENSE="GPL-3"
SLOT="0"

IUSE="+xdg +freeze"

RDEPEND="
	app-misc/jq
	app-shells/bash
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/hyprland
	x11-libs/libnotify
	xdg? ( x11-misc/xdg-user-dirs )
	freeze? ( gui-apps/hyprpicker )
"

src_install() {
	dobin hyprshot
	einstalldocs
}
