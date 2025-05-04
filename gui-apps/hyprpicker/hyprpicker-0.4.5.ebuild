# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A wlroots-compatible Wayland color picker that does not suck"
HOMEPAGE="https://github.com/hyprwm/hyprpicker"

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
	>=dev-util/hyprwayland-scanner-0.4.2
	gui-libs/hyprutils:=
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"
DEPEND="${RDEPEND}"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	media-libs/libglvnd
	media-libs/libjpeg-turbo
"
