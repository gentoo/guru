# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Fun RTS from 2001 by Hungarian developer StormRegion, similar to Ground Control"
HOMEPAGE="https://en.wikipedia.org/wiki/S.W.I.N.E."

SRC_URI="https://archive.org/download/$PN.tar.xz/$PN.tar.xz"

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

	exec=swine.exe

	mkdir -p "$ED$/opt"

	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die
	fperms o+w "/opt/$PN/$PN.log" # Will not start without it

	echo "cd /opt/$PN; wine $exec; cd -" > "$ED/usr/bin/$PN"
	# I tried
	# make_wrapper "$PN" "env WINEPREFIX=/home/\$USER/.wine-swine wine /opt/$PN/swine.exe"
	# but game got error - because we need to run from the game directory
	fperms +x "/usr/bin/$PN"

}

pkg_postinst() {
	einfo "Downloaded from https://www.moddb.com/games/swn/downloads/s-w-i-n-e-full-game"
	einfo "More about the game:"
	einfo "https://www.youtube.com/channel/UCNtssCCyFCEr6N8N5T9kvHQ"
	einfo "https://www.wikidata.org/wiki/Q844994"
	einfo "https://www.metacritic.com/game/s-w-i-n-e/"
	einfo "The game is installed to /opt/$PN/ - if you want to run it by another Wine or operating system"
}
