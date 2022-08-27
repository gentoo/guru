# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

IMGUI_VER="1.81"
IMGUI_MESON_WRAP_VER="1"

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="
	https://github.com/ocornut/imgui
"

SRC_URI="
	https://github.com/ocornut/imgui/archive/v${IMGUI_VER}.tar.gz -> imgui-${IMGUI_VER}.tar.gz
"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="dx9 dx10 dx11 dx12 metal opengl vulkan glfw sdl2 osx win marmalade allegro5"

RDEPEND="
	dev-libs/stb:=
	media-libs/glew
	allegro5? ( media-libs/allegro:5 )
	glfw? ( media-libs/glfw:0 )
	opengl? ( virtual/opengl )
	sdl2? ( media-libs/libsdl2 )
	vulkan? ( media-libs/vulkan-loader )
"
DEPEND="
	${RDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	virtual/pkgconfig
"

src_unpack() {
	default

	cp ${FILESDIR}/imgui-${IMGUI_VER}-meson.build ${S}/meson.build || die
	cp ${FILESDIR}/imgui-${IMGUI_VER}-meson_options.txt ${S}/meson_options.txt || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature dx9)
		$(meson_feature dx10)
		$(meson_feature dx11)
		$(meson_feature dx12)
		$(meson_feature metal)
		$(meson_feature opengl)
		$(meson_feature vulkan)
		$(meson_feature glfw)
		$(meson_feature sdl2)
		$(meson_feature osx)
		$(meson_feature win)
		$(meson_feature marmalade)
		$(meson_feature allegro5)
	)
	meson_src_configure
}
