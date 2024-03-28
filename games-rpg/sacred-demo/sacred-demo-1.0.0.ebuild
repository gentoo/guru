# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Like Diablo, isometric view, good rating, about a two hours of the gameplay"
HOMEPAGE="https://en.wikipedia.org/wiki/Sacred_(video_game)"

SRC_URI="https://archive.org/download/$PN.tar/$PN.tar.xz"

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	virtual/wine
"

QA_PREBUILT="*"

src_install() {

	mkdir -p "$ED$/opt"

	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die

	echo "cd /opt/$PN; WINEPREFIX=\$HOME/.wine-sacred/ wine /opt/$PN/Sacred.exe; cd -" > "$ED/usr/bin/$PN"
	fperms +x "/usr/bin/$PN"
	fperms 777 "/opt/$PN/"

}

pkg_postinst() {
	einfo "More about the game:"
	einfo "https://www.wikidata.org/wiki/Q1757845"
	einfo ""
	einfo "Buy the full game at https://store.steampowered.com/app/12320/Sacred_Gold/"
	einfo ""
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
