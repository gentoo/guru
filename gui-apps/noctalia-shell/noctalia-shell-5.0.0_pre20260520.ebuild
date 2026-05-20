# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_COMMIT="e0566190d9f7f35f29a915fa58b1a4c37c32ed26"

DESCRIPTION="A lightweight Wayland shell and bar built directly on Wayland + OpenGL ES"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-shell"

SRC_URI="https://github.com/noctalia-dev/noctalia-shell/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	dev-cpp/sdbus-c++
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libwebp
	gnome-base/librsvg:2
	media-video/pipewire
	net-misc/curl
	sys-libs/pam
	x11-libs/cairo[glib]
	x11-libs/pango
	x11-libs/libxkbcommon
	media-libs/mesa
	virtual/opengl
	dev-libs/wayland
	sys-auth/polkit
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"

DOCS=( README.md CREDITS.md example.toml )
