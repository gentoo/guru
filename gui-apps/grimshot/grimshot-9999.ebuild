# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A helper for screenshots within sway"
HOMEPAGE="https://github.com/OctopusET/sway-contrib"

EGIT_REPO_URI="https://github.com/OctopusET/sway-contrib.git"

LICENSE="MIT"
SLOT="0"

IUSE="libnotify"

RDEPEND="
	app-misc/jq
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/sway
	!!<=gui-wm/sway-1.8.1[grimshot]
	libnotify? ( x11-libs/libnotify )
"

src_install() {
	dobin grimshot
	doman grimshot.1
}
