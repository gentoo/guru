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
IUSE="system-glfw system-glew system-stb system-kissfft"

# TODO: system-miniaudio, system-jsonxx/json++, system-scintilla
DEPEND="
	system-glfw? ( media-libs/glfw )
	system-glew? ( media-libs/glew:= )
	system-stb? ( dev-libs/stb )
	system-kissfft? ( sci-libs/kissfft )
	virtual/opengl
	media-libs/alsa-lib
	media-libs/fontconfig
	x11-libs/libXinerama
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBONZOMATIC_USE_SYSTEM_GLFW=$(usex system-glfw)
		-DBONZOMATIC_USE_SYSTEM_GLEW=$(usex system-glew)
		-DBONZOMATIC_USE_SYSTEM_STB=$(usex system-stb)
		-DBONZOMATIC_USE_SYSTEM_KISSFFT=$(usex system-kissfft)
	)

	cmake_src_configure
}
