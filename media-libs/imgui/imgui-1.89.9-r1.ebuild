# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

MESON_WRAP_VER="1"

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="
	https://github.com/ocornut/imgui
"

SRC_URI="https://github.com/ocornut/imgui/archive/v${PV}.tar.gz -> imgui-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="opengl vulkan glfw sdl2 sdl_renderer webgpu allegro5"

RDEPEND="
	dev-libs/stb:=
	media-libs/glew[${MULTILIB_USEDEP}]
	allegro5? ( media-libs/allegro:5[${MULTILIB_USEDEP}] )
	glfw? ( media-libs/glfw:0[${MULTILIB_USEDEP}] )
	opengl? ( virtual/opengl[${MULTILIB_USEDEP}] )
	sdl2? ( media-libs/libsdl2[${MULTILIB_USEDEP}] )
	sdl_renderer? ( media-libs/libsdl2[${MULTILIB_USEDEP}] )
	vulkan? ( media-libs/vulkan-loader[${MULTILIB_USEDEP}] )
"
DEPEND="
	${RDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	# Use custom meson.build and meson_options.txt to install instead of relay on packages
	cp "${FILESDIR}/${PN}-meson.build" "${S}/meson.build" || die
	cp "${FILESDIR}/${PN}-meson_options.txt" "${S}/meson_options.txt" || die
	sed -i "s/  version: 'PV',/  version: '${PV}',/g" "${S}/meson.build" || die
}

multilib_src_configure() {
	local emesonargs=(
		-Ddx9=disabled
		-Ddx10=disabled
		-Ddx11=disabled
		-Ddx12=disabled
		-Dmetal=disabled
		$(meson_feature opengl)
		$(meson_feature vulkan)
		$(meson_feature glfw)
		$(meson_feature sdl2)
		$(meson_feature sdl_renderer)
		$(meson_feature webgpu)
		-Dosx=disabled
		-Dwin=disabled
		$(meson_feature allegro5)
	)
	meson_src_configure
}
