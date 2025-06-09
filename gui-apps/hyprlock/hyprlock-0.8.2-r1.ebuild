# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland's GPU-accelerated screen locking utility"
HOMEPAGE="https://github.com/hyprwm/hyprlock"

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
	dev-cpp/sdbus-c++:0/2
	dev-libs/date
	dev-libs/glib:2
	dev-libs/hyprgraphics
	>=dev-libs/hyprlang-0.6.0
	dev-libs/wayland
	>=dev-util/hyprwayland-scanner-0.4.4
	>=gui-libs/hyprutils-0.5.0:=
	media-libs/libglvnd
	media-libs/libjpeg-turbo:=
	media-libs/libwebp:=
	media-libs/mesa[opengl]
	sys-libs/pam
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-0.4.1-fix-CFLAGS-CXXFLAGS.patch"
)
