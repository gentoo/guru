# Copyright 2018-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="rewrite of the jump-and-run platformer Doukutsu Monogatari(Cave Story)"
HOMEPAGE="https://github.com/nxengine/nxengine-evo http://nxengine.sourceforge.net/"

MY_PV="${PV/_p/-}"
SRC_URI="
	https://github.com/nxengine/nxengine-evo/archive/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
	https://www.cavestory.org/downloads/cavestoryen.zip
"
S="${WORKDIR}/${PN}-${MY_PV}"

SLOT="0"
LICENSE="GPL-3 freedist"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libpng:=
	media-libs/libsdl2:=
	media-libs/sdl2-mixer:=
	media-libs/sdl2-ttf:=
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/nxengine-evo-2.6.5-1-gcc13.patch"
)

src_compile() {
	cmake_src_compile

	cp -r data "${WORKDIR}/CaveStory" || die
	cd "${WORKDIR}/CaveStory" || die
	"${BUILD_DIR}/nxextract" || die
}

src_install() {
	cmake_src_install

	cd "${WORKDIR}/CaveStory" || die

	insinto /usr/share/nxengine
	doins -r data

	newdoc Readme.txt Doukutsu-Readme.txt
	docinto html
	newdoc Manual.html Doukutsu-Manual.html
	dodoc -r Manual
}
