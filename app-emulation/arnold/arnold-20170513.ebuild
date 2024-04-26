# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0-gtk3"

inherit cmake desktop wxwidgets

DESCRIPTION="Amstrad CPC emulator"
HOMEPAGE="http://www.cpctech.org.uk"
SRC_URI="http://cpctech.cpc-live.com/arnsrc.zip -> ${P}.zip"

S=${WORKDIR}/src

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="inkz80"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
	x11-libs/wxGTK:${WX_GTK_VER}
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

src_prepare() {
	setup-wxwidgets
	sed -i "4421s:=.*$:=wxT(\"/usr/share/${PN}/\");:" arngui/arnguiApp.cpp || die
	# Prevent running at 150%
	sed -i '390s/20000/30000/' arngui/sdl2/SDL2PlatformSpecific.cpp || die
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_SKIP_RPATH=YES
		-DZ80_VERSION="USE_$(usex inkz80 INK ARN)Z80"
		-DSDL_VERSION="USE_SDL2"
	)
	cmake_src_configure
}

src_install() {
	cd "${WORKDIR}"/exe/Gentoo/${PN} || die
	doicon "${FILESDIR}"/${PN}.png
	insinto /usr/share/${PN}/
	dobin arnold
	doins *.*
}
