# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU Public License v2

EAPI=8

inherit meson

MY_COMMIT="5c4ef835c539b9e8e489abba1e9f0dd4f8a23a51"

DESCRIPTION="An independent compositor made by noctalia"
HOMEPAGE="https://github.com/noctalia-dev/umbriel https://noctalia.dev/"

SRC_URI="https://github.com/noctalia-dev/umbriel/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jemalloc X screencast"

DEPEND="
	gui-libs/wlroots:0.20[X?]
	>=dev-libs/libinput-1.26.0
	>=dev-libs/wayland-1.24.0
	jemalloc? ( dev-libs/jemalloc )
	dev-cpp/tomlplusplus
	dev-cpp/nlohmann_json
	x11-libs/cairo
	x11-libs/pango
	>=x11-libs/libdrm-2.4.122
	>=x11-libs/libxkbcommon-1.5.0
	>=x11-libs/pixman-0.43.0
	media-libs/libglvnd
	media-libs/mesa[egl(+),gles2(+)]
	!gui-libs/scenefx
"
RDEPEND="
	${DEPEND}
	X? ( gui-apps/xwayland-satellite )
	screencast? ( sys-apps/xdg-desktop-portal-umbriel )
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	>=dev-build/meson-1.3
	dev-build/ninja
	virtual/pkgconfig
	dev-util/wayland-scanner
"

src_configure() {
	local emesonargs=(
		$(meson_feature jemalloc)
	)

	meson_src_configure
}
