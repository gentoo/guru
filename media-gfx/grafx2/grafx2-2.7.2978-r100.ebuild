# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit lua-single xdg

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://www.pulkomandy.tk/projects/GrafX2"
SRC_URI="http://www.pulkomandy.tk/projects/GrafX2/downloads/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua ttf"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
# Test phase fails: make: *** [Makefile:1146: ../bin/tests-sdl] Error 1
RESTRICT="test"

DEPEND="
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/freetype
	media-libs/libpng
	ttf? ( media-libs/sdl-ttf )
	lua? ( ${LUA_DEPS} )
"

S="${WORKDIR}/${PN}/src/"

PATCHES=( "${FILESDIR}/${PN}-desktop-file.patch" )

src_prepare() {
	pushd ../ && default && popd
	sed -i s/lua5\.1/lua/g Makefile || die "sed failed"
}

src_compile() {
	use ttf || MYCNF="NOTTF=1"
	use lua || MYCNF="${MYCNF} NOLUA=1"

	emake ${MYCNF} || die "emake failed"
}

src_install() {
	emake ${MYCNF} DESTDIR="${D}" PREFIX="/usr" install || die "Install failed"
}
