# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="RTS with high rating from 2004, like WarCraft III or Armies of Exigo"
HOMEPAGE="https://en.wikipedia.org/wiki/Warhammer_40%2C000%3A_Dawn_of_War"

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

	mkdir -p "$ED$/opt" || die

	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die

	conty='conty-1.25.2'

	echo "cd /opt/$PN; $conty wine $PN; cd -" > "$ED/usr/bin/$PN" || die
	fperms +x "/usr/bin/$PN"

}

pkg_postinst() {
	einfo "More about the game:"
	einfo "https://store.steampowered.com/app/4570/Warhammer_40000_Dawn_of_War__Game_of_the_Year_Edition/"
	einfo "https://www.wikidata.org/wiki/Q1061708"
	einfo "https://www.pcgamingwiki.com/wiki/Warhammer_40%2C000%3A_Dawn_of_War"
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
