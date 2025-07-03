# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU Public License v2

EAPI=8

inherit meson

DESCRIPTION="A replacement for the wlroots scene API with eye-candy effects."
HOMEPAGE="https://github.com/wlrfx/scenefx"

SRC_URI="https://github.com/wlrfx/scenefx/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="examples X"

DEPEND="
	>=dev-libs/wayland-1.23.0
	>=x11-libs/libdrm-2.4.122
	media-libs/mesa[egl(+),gles2(+)]
	>=x11-libs/pixman-0.42.0
	media-libs/libglvnd
	x11-libs/libxkbcommon
"

DEPEND+="
	>=gui-libs/wlroots-0.18:=[X?]
	<gui-libs/wlroots-0.19:=[X?]
"

RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.35
	>=dev-build/meson-0.59.0
	virtual/pkgconfig
	dev-build/ninja
	dev-util/wayland-scanner
"

src_configure() {
	local emesonargs=(
		-Drenderers='gles2'
		$(meson_use examples)
	)

	meson_src_configure
}
