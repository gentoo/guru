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
IUSE="examples liftoff +libinput +drm vulkan x11-backend xcb-errors X"
REQUIRED_USE="
	xcb-errors? ( || ( x11-backend X ) )
"

DEPEND="
	>=dev-libs/wayland-1.22.0
	>=x11-libs/libdrm-2.4.114
	media-libs/mesa[egl(+),gles2(+)]
	>=x11-libs/pixman-0.42.0
	media-libs/libglvnd
	x11-libs/libxkbcommon
	drm? (
		media-libs/libdisplay-info
		sys-apps/hwdata
		liftoff? ( >=dev-libs/libliftoff-0.4 )
	)
	libinput? ( >=dev-libs/libinput-1.14.0:= )
	x11-backend? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-renderutil
	)
	vulkan? (
		dev-util/glslang:=
		dev-util/vulkan-headers
		media-libs/vulkan-loader
	)
	xcb-errors? ( x11-libs/xcb-util-errors )
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
		x11-base/xwayland
	)
"
DEPEND+="
	>=gui-libs/wlroots-0.17:=[X?]
	<gui-libs/wlroots-0.18:=[X?]
"

RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	>=dev-build/meson-0.59.0
	virtual/pkgconfig
	dev-build/ninja
"

src_configure() {
	local backends=(
		$(usev drm)
		$(usev libinput)
		$(usev x11-backend 'x11')
	)
	local meson_backends=$(IFS=','; echo "${backends[*]}")
	local emesonargs=(
		-Drenderers=$(usex vulkan 'gles2,vulkan' gles2)
		$(meson_feature X xwayland)
		$(meson_feature xcb-errors)
		$(meson_use examples)
		-Dbackends=${meson_backends}
	)

	meson_src_configure
}
