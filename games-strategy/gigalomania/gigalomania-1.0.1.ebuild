# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Libre clone of Mega-Lo-Mania (original from ~1990), supports original resources"
HOMEPAGE="https://gigalomania.sourceforge.net"
SRC_URI="http://launchpad.net/$PN/trunk/$PV/+download/${PN}src.zip"

S="$WORKDIR/${PN}src"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-arch/unzip
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-mixer
"

src_compile() {
	emake
}

src_install() {
	DESTDIR="$D" emake install

	make_wrapper $PN "./$PN" /opt/$PN/
}

pkg_postinst() {
	einfo "Supports using the graphics from Mega-Lo-Mania (from the Amiga version - should be in hard disk format, e.g., Whdload version) if you have that game."
	einfo "The data/ folder should be copied into the main gigalomania/ folder"
	einfo "and then rename the gfx/ folder to something else (e.g., xgfx/)."
	einfo "It's up to you to legally obtain the game if you want this feature!"
}
