# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature xdg

MY_PV="${PV/_/-}"
MY_PV="${MY_PV:0:-1}.${MY_PV: -1}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A lightweight Wayland shell and bar built directly on Wayland + OpenGL ES"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia"

SRC_URI="https://github.com/noctalia-dev/noctalia/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"

IUSE="+jemalloc"

DEPEND="
	dev-cpp/nlohmann_json
	dev-cpp/sdbus-c++
	dev-cpp/tomlplusplus
	dev-libs/glib:2
	jemalloc? ( dev-libs/jemalloc:= )
	dev-libs/libxml2
	dev-libs/md4c
	dev-libs/stb
	dev-libs/libsodium
	dev-libs/wayland
	app-crypt/libsecret
	gnome-base/librsvg:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libwebp
	media-libs/mesa
	media-video/pipewire
	media-video/wireplumber
	net-misc/curl
	sci-libs/libqalculate
	sys-auth/polkit
	sys-libs/pam
	virtual/opengl
	x11-libs/cairo[glib]
	x11-libs/libxkbcommon
	x11-libs/pango
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"

DOCS=( {README,CREDITS}.md example.toml )

src_configure() {
	local emesonargs=(
		$(meson_feature jemalloc)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "external display brightness control" app-misc/ddcutil
	optfeature "battery and power device integration" sys-power/upower
	optfeature "clipboard auto-paste" gui-apps/wtype
	optfeature "hardware-accelerated screen recording" media-video/gpu-screen-recorder
}
