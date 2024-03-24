# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Turn-based, sci-fi, like a chess, from 2006, any screen resolution, good rating"
HOMEPAGE="http://www.massiveassaultnetwork.com/man2/"

SRC_URI="https://archive.org/download/$PN.tar/$PN.tar.xz"

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	~games-emulation/conty-1.25.2:0
"
# TODO add USE flag to be able to choolse local wine or wine-proton, against 1.4 GB dependency?

QA_PREBUILT="*"

src_install() {

	mkdir -p "$ED$/opt"

	rm "$PN/uninstall.exe"
	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die

	conty='conty-1.25.2'

	echo "cd /opt/$PN; $conty wine man2.exe; cd -" > "$ED/usr/bin/$PN"
	fperms +x "/usr/bin/$PN"
	# I tried this but on run error: "Problems during decoding OGG files" -
	# because I need to run from the directory of the game,
	# but cd does not works with exec
	# make_wrapper "$PN" "$conty wine /opt/$PN/man2.exe /d /opt/$PN"

}

pkg_postinst() {
	einfo "More about the game:"
	einfo "https://en.wikipedia.org/wiki/Massive_Assault_Network_2"
	einfo "Wikidata: https://www.wikidata.org/wiki/Q4043784"
	einfo "https://www.mobygames.com/game/44100/massive-assault-network-2"
	einfo "https://www.metacritic.com/game/massive-assault-network-2"
	einfo "Discord: https://discord.gg/u76RQ98U"
	einfo "Buy the full game: https://www.humblebundle.com/store/massive-assault-network-2"
	einfo "Downloaded from http://www.massiveassaultnetwork.com/download/man2demo.exe, installed, archived"
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
