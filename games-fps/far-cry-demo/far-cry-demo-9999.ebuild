# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Famous game from 2004"
HOMEPAGE="https://en.wikipedia.org/wiki/Far_Cry_(video_game)"

SRC_URI="https://archive.org/download/$PN.tar.xz/$PN.tar.xz"

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	~games-emulation/conty-1.25.2:0
"

QA_PREBUILT="*"

src_install() {

	path="/opt/games/"
	conty=conty-1.25.2

	dodir $path
	dodir /usr/bin
	cp -r . "$ED/$path" || die

	pr="WINEPREFIX=/home/\$USER/.wine-far-cry-demo"

	echo "cd $path$PN; $pr $conty wine /opt/games/$PN/FarCry.exe; cd -" > "$ED/usr/bin/$PN"
	fperms +x "/usr/bin/$PN"

}

pkg_postinst() {
	einfo "Downloaded from https://www.moddb.com/games/far-cry/downloads/far-cry-demo-1"
	einfo ""
	einfo "More about the game:"
	einfo "https://www.wikidata.org/wiki/Q337865"
	einfo "https://appdb.winehq.org/objectManager.php?sClass=version&iId=37029"
	einfo ""
	einfo "Buy the full game at"
	einfo "https://store.steampowered.com/app/13520/Far_Cry/"
	einfo "https://www.gog.com/game/far_cry"
	einfo "https://www.humblebundle.com/store/far-cry"
	einfo ""
	einfo "The game is installed to $path$PN - if you want to run it by another Wine or operating system"
}
