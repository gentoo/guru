# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An application to enable a blue-light filter on Hyprland"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprsunset"

if [[ "${PV}" = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/${PN^}.git"
else
	SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	>=gui-libs/hyprutils-0.2.3:=
	gui-wm/hyprland:=
"

DEPEND="
	${RDEPEND}
	>=dev-libs/hyprland-protocols-0.4.0
	dev-libs/wayland-protocols
	>=dev-util/hyprwayland-scanner-0.4.0
	dev-util/wayland-scanner
"

BDEPEND="
	virtual/pkgconfig
"
