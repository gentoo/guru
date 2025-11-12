# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/wlrfx/scenefx"
	inherit git-r3
else
	SRC_URI="https://github.com/wlrfx/scenefx/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
	KEYWORDS="~amd64 ~arm64"
fi

DESCRIPTION="A replacement for the wlroots scene API with eye-candy effects."
HOMEPAGE="https://github.com/wlrfx/scenefx"

LICENSE="MIT"
SLOT="0"
IUSE="examples X"

DEPEND="
	>=dev-libs/wayland-1.23.1
	>=x11-libs/libdrm-2.4.122
	media-libs/mesa[egl(+),gles2(+)]
	>=x11-libs/pixman-0.43.0
	media-libs/libglvnd
	x11-libs/libxkbcommon
"

DEPEND+="
	>=gui-libs/wlroots-0.19:=[X?]
	<gui-libs/wlroots-0.20:=[X?]
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
