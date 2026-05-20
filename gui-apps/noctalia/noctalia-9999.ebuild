# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A lightweight Wayland shell and bar built directly on Wayland + OpenGL ES, with no Qt or GTK dependency."
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-shell"

inherit git-r3
EGIT_REPO_URI="https://github.com/noctalia-dev/noctalia-shell.git"
EGIT_BRANCH="v5"

LICENSE="MIT"
SLOT="0"

IUSE="jemalloc"

DEPEND="
	dev-libs/wayland-protocols
	dev-libs/wayland
	media-libs/libglvnd
	media-libs/freetype
	media-libs/fontconfig
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libxkbcommon
	dev-cpp/sdbus-c++
	media-video/pipewire
	sys-auth/polkit
	sys-libs/pam
	net-misc/curl
	media-libs/libwebp
	gnome-base/librsvg
	jemalloc? ( dev-libs/jemalloc )
"
RDEPEND="${DEPEND}"

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_install
}
