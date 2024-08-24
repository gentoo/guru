# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A wlroots-compatible Wayland color picker that does not suck"
HOMEPAGE="https://github.com/hyprwm/hyprpicker"
EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git/"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	>=gui-libs/hyprutils-0.2.0
"

BDEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	media-libs/libglvnd
	media-libs/libjpeg-turbo
"
