# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package package for nwg-shell"
HOMEPAGE="https://nwg-piotr.github.io/nwg-shell/"

S="${WORKDIR}"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/nwg-look
	app-misc/nwg-shell-wallpapers
	gui-apps/nwg-displays
	gui-apps/nwg-dock
	gui-apps/nwg-dock
	gui-apps/nwg-drawer
	gui-apps/nwg-icon-picker
	gui-apps/nwg-menu
	gui-apps/nwg-panel
	gui-apps/nwg-shell
	gui-apps/nwg-shell-config
"
