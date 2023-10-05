# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A helper for screenshots within sway"
HOMEPAGE="https://github.com/OctopusET/sway-contrib"

EGIT_REPO_URI="https://github.com/OctopusET/sway-contrib.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

IUSE="libnotify"

RDEPEND="
	app-misc/jq
	gui-apps/grim
	gui-apps/slurm
	gui-apps/wl-clipboard
	gui-wm/sway
	libnotify? ( x11-libs/libnotify )
"

src_install() {
	dobin grimshot
	doman grimshot.1
}
