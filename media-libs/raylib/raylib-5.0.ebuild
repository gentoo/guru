# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A simple and easy-to-use library to learn videogames programming"
HOMEPAGE="https://www.raylib.com/"

LICENSE="ZLIB"
SLOT="0"

IUSE="alsa examples static-libs +system-glfw X wayland"
REQUIRED_USE="|| ( system-glfw || ( X wayland ) )"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/raysan5/raylib.git"
	inherit git-r3
else
	SRC_URI="https://github.com/raysan5/raylib/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/raylib-${PV}"
fi

RDEPEND="
	alsa? ( media-libs/alsa-lib )
	X? (
		virtual/opengl
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXxf86vm
	)
	wayland? (
		dev-libs/wayland
		media-libs/mesa[wayland]
	)
	system-glfw? ( >=media-libs/glfw-3.2.1 )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs ON OFF)
		-DUSE_AUDIO=$(usex alsa ON OFF)
		-DUSE_EXTERNAL_GLFW=$(usex system-glfw ON OFF)
		-DBUILD_EXAMPLES=OFF
	)
	if use !system-glfw; then
		mycmakeargs+=(-DGLFW_BUILD_WAYLAND=$(usex wayland ON OFF))
		mycmakeargs+=(-DGLFW_BUILD_X11=$(usex X ON OFF))
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use examples; then
		dodoc -r "${S}"/examples/*
	fi
}
