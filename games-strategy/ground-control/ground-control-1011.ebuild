# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="From 2000, Metacritic is 75"
HOMEPAGE="https://en.wikipedia.org/wiki/Ground_Control_(video_game)"

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

	make_wrapper "$PN" "env WINEPREFIX=/home/\$USER/.wine-ground-control wine /opt/$PN/gc.exe"

}

pkg_postinst() {
	einfo "Downloaded from https://www.moddb.com/games/ground-control/downloads/ground-control-install"
	einfo "More about the game:"
	einfo "https://www.wikidata.org/wiki/Q1547686"
	einfo "https://www.metacritic.com/game/1300002617/"
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
