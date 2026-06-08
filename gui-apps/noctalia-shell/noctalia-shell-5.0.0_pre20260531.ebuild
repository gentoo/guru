# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature

MY_COMMIT="298fad1678d23c964aa8ea56bfe9dc3c84eed6a4"

DESCRIPTION="A lightweight Wayland shell and bar built directly on Wayland + OpenGL ES"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-shell"

SRC_URI="https://github.com/noctalia-dev/noctalia-shell/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"

IUSE="+jemalloc"

DEPEND="
	dev-cpp/sdbus-c++
	dev-libs/glib:2
	jemalloc? ( dev-libs/jemalloc:= )
	dev-libs/libxml2
	dev-libs/wayland
	gnome-base/librsvg:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libwebp
	media-libs/mesa
	media-video/pipewire
	net-misc/curl
	sci-libs/libqalculate
	sys-auth/polkit
	sys-libs/pam
	virtual/opengl
	x11-libs/cairo[glib]
	x11-libs/libxkbcommon
	x11-libs/pango
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"

DOCS=( README.md CREDITS.md example.toml )

src_configure() {
	local emesonargs=(
		$(meson_feature jemalloc)
	)
	meson_src_configure
}

pkg_postinst() {
	optfeature "external display brightness control" app-misc/ddcutil
	optfeature "hardware-accelerated screen recording" media-video/gpu-screen-recorder
}
