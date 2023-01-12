# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A video wallpaper program for wlroots based wayland compositors"
HOMEPAGE="https://github.com/GhostNaN/mpvpaper"

inherit meson

case "${PV}" in
	9999)
		inherit git-r3
		EGIT_REPO_URI="https://github.com/GhostNaN/mpvpaper.git"
		;;
	*)
		SRC_URI="https://github.com/GhostNaN/mpvpaper/archive/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64"
esac

LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror test"

RDEPEND="
	media-video/mpv[libmpv]
	gui-libs/wlroots
"
DEPEND="${RDEPEND}"
