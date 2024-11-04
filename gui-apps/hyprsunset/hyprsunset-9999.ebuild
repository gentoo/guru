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
	>=dev-libs/hyprland-protocols-0.4.0
"
DEPEND="
	${RDEPEND}
	dev-util/wayland-scanner
	>=gui-libs/hyprutils-0.2.3
	>=dev-util/hyprwayland-scanner-0.4.0
	virtual/pkgconfig
"
