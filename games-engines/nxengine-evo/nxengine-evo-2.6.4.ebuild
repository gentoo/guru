# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="rewrite of the jump-and-run platformer Doukutsu Monogatari(Cave Story)"
HOMEPAGE="https://github.com/nxengine/nxengine-evo http://nxengine.sourceforge.net/"
SRC_URI="
	https://github.com/nxengine/nxengine-evo/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://www.cavestory.org/downloads/cavestoryen.zip
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libpng:=
	media-libs/libsdl2:=
	media-libs/sdl2-mixer:=
	media-libs/sdl2-ttf:=
"
BDEPEND="app-arch/unzip"

src_compile() {
	cmake_src_compile

	cp -r data/ "${WORKDIR}/CaveStory"
	cd "${WORKDIR}/CaveStory"
	"${S}"/bin/extract
}

src_install() {
	newbin bin/extract nx-extract
	dobin bin/nx

	dodir /usr/share
	cp -r "${WORKDIR}/CaveStory/" "${ED}/usr/share/nxengine"
}
