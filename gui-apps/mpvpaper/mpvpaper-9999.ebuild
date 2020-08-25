# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A video wallpaper program for wlroots based wayland compositors"
HOMEPAGE="https://github.com/GhostNaN/mpvpaper"

inherit git-r3 meson
EGIT_REPO_URI="https://github.com/GhostNaN/mpvpaper.git"

LICENSE="GPL-3"
SLOT="0"

RDEPENDS="
	media-video/mpv[libmpv]
	gui-libs/wlroots
"
DEPENDS="${RDEPENDS}"
