# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU Public License v2

EAPI=8

inherit meson

MY_COMMIT="ee380d66984a45310ef48a283ad806ebab752788"

DESCRIPTION="XDG Desktop Portal for Umbriel"
HOMEPAGE="https://github.com/noctalia-dev/xdg-desktop-portal-umbriel https://noctalia.dev/"

SRC_URI="https://github.com/noctalia-dev/xdg-desktop-portal-umbriel/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/wayland-1.24.0
	dev-libs/glib:2
	media-libs/mesa
	dev-cpp/tomlplusplus
	x11-libs/cairo
	>=x11-libs/libdrm-2.4.122
	gui-libs/gtk:4
	dev-cpp/sdbus-c++:=
	dev-cpp/nlohmann_json
	media-video/pipewire:=
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
"
