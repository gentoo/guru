# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit lua-single xdg

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://www.pulkomandy.tk/projects/GrafX2"
SRC_URI="http://www.pulkomandy.tk/projects/GrafX2/downloads/${P}-src.tgz"

S="${WORKDIR}/${PN}/src/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua ttf"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"

# Test phase fails: make: *** [Makefile:1146: ../bin/tests-sdl] Error 1
RESTRICT="test"

DEPEND="
	media-libs/libsdl
	media-libs/sdl-image[tiff]
	media-libs/freetype
	media-libs/libpng
	ttf? ( media-libs/sdl-ttf )
	lua? ( ${LUA_DEPS} )
"

PATCHES=( "${FILESDIR}/${PN}-desktop-file.patch" )

src_prepare() {
	pushd ../ && default && popd
}

src_compile() {
	use ttf || MYCNF="NOTTF=1"
	use lua || MYCNF="${MYCNF} NOLUA=1"

	emake ${MYCNF}
}

src_install() {
	emake ${MYCNF} DESTDIR="${ED}" PREFIX="/usr" install
}
