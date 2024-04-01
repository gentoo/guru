# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="HoMM 5, a few maps included. Camera zoom looks like broken. Metacritic: 77"
HOMEPAGE="https://en.wikipedia.org/wiki/Heroes_of_Might_and_Magic_V"

SRC_URI="https://archive.org/download/$PN.tar.xz/$PN.tar.xz"

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	virtual/wine
	app-emulation/dxvk
"

QA_PREBUILT="*"

src_install() {

	mkdir -p "$ED$/opt"

	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die

	make_wrapper "$PN" "env WINEPREFIX=/home/\$USER/.wine-homm5 wine /opt/$PN/bin/H5_Game.exe"

}

pkg_postinst() {
	einfo "Downloaded from https://www.moddb.com/games/heroes-of-might-and-magic-5/downloads/heroes-of-might-and-magic-v-demo"
	einfo "More about the game:"
	einfo "https://www.wikidata.org/wiki/Q2450"
	einfo "https://www.metacritic.com/game/heroes-of-might-and-magic-v/"
	einfo ""
	einfo "Buy the full game at"
	einfo "https://www.gog.com/en/game/heroes_of_might_and_magic_5_bundle"
	einfo "https://store.steampowered.com/app/15170/Heroes_of_Might__Magic_V/"
	einfo "https://www.humblebundle.com/store/heroes-of-might-magic-v"
	einfo ""
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
