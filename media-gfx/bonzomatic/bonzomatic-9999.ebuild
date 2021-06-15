# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Live shader coding tool and Shader Showdown workhorse"
HOMEPAGE="https://github.com/Gargaj/Bonzomatic"
if [[ "${PV}" == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Gargaj/Bonzomatic"
else
	MY_PV="$(ver_rs 1- -)"
	SRC_URI="https://github.com/Gargaj/Bonzomatic/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Bonzomatic-${MY_PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Unlicense"
SLOT="0"
IUSE="system-glfw system-glew system-stb system-kissfft wayland"

# TODO: system-miniaudio, system-jsonxx/json++, system-scintilla
# !system-glfw copied from media-libs/glfw-3.3.3::gentoo
# !system-glew copied from media-libs/glew-2.2.0::gentoo
DEPEND="
	system-glfw? ( media-libs/glfw )
	!system-glfw? (
		wayland? (
			dev-libs/wayland
			media-libs/mesa[egl,wayland]
			dev-libs/wayland-protocols
		)
		!wayland? (
			x11-libs/libX11
			x11-libs/libXcursor
			x11-libs/libXinerama
			x11-libs/libXrandr
			x11-libs/libXxf86vm
			x11-libs/libXi
		)
	)
	system-glew? ( media-libs/glew:= )
	!system-glew? (
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXext-1.3.2
		>=x11-libs/libXi-1.7.2
		>=x11-libs/libXmu-1.1.1-r1
	)
	system-stb? ( dev-libs/stb )
	system-kissfft? ( sci-libs/kissfft )
	virtual/opengl
	virtual/glu
	media-libs/alsa-lib
	media-libs/fontconfig
"
RDEPEND="${DEPEND}"
BDEPEND="!system-glfw? ( wayland? ( dev-libs/wayland-protocols ) )"

src_configure() {
	local mycmakeargs=(
		-DBONZOMATIC_USE_SYSTEM_GLFW=$(usex system-glfw)
		-DGLFW_USE_WAYLAND="$(usex wayland)"
		-DBONZOMATIC_USE_SYSTEM_GLEW=$(usex system-glew)
		-DBONZOMATIC_USE_SYSTEM_STB=$(usex system-stb)
		-DBONZOMATIC_USE_SYSTEM_KISSFFT=$(usex system-kissfft)
	)

	cmake_src_configure
}
