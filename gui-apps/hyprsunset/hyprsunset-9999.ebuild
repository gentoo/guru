# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake git-r3

DESCRIPTION="An application to enable a blue-light filter on Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprsunset.git"
EGIT_REPO_URI="https://github.com/hyprwm/hyprsunset.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	~gui-wm/hyprland-9999
	dev-libs/wayland
	>=gui-libs/hyprutils-0.2.3
"

DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
	>=dev-libs/hyprland-protocols-0.4.0
	>=dev-util/hyprwayland-scanner-0.4.0
	dev-util/wayland-scanner
"

BDEPEND="
	virtual/pkgconfig
"
