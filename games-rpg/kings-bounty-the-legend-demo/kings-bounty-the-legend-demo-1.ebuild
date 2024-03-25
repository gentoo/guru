# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="With battles like in Heroes of Might and Magic (HoMM)"
HOMEPAGE="https://en.wikipedia.org/wiki/King%27s_Bounty:_The_Legend"

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

	make_wrapper "$PN" "wine /opt/$PN/kb.exe"

}

pkg_postinst() {
	einfo "DXVK increase FPS, so try setup_dxvk.sh install --symlink"
	einfo "Downloaded from https://www.moddb.com/games/kings-bounty-the-legend/downloads/king-s-bounty-the-legend-updated-demo, installed, archived"
	einfo ""
	einfo "More about the game:"
	einfo "https://www.wikidata.org/wiki/Q2442910"
	einfo "https://www.twitch.tv/directory/category/kings-bounty-the-legend/videos/all"
	einfo "https://www.metacritic.com/game/kings-bounty-the-legend"
	einfo "http://www.lki.ru/games.php?Game=KB2_battlelord"
	einfo "https://www.pcgamingwiki.com/wiki/King's_Bounty:_The_Legend"
	einfo "https://www.mobygames.com/game/34196/kings-bounty-the-legend"
	einfo "https://howlongtobeat.com/game/5020"
	einfo "https://www.igdb.com/games/king-s-bounty-the-legend"
	einfo "https://kingsbounty.fandom.com/ru/wiki/King's_Bounty:_Легенда_о_Рыцаре"
	einfo "https://appdb.winehq.org/appview.php?iAppId=7301"
	einfo "https://lutris.net/games/kings-bounty-the-legend"
	einfo ""
	einfo "Buy the full game at https://www.gog.com/en/game/kings_bounty_the_legend"
	einfo "https://store.steampowered.com/app/25900/Kings_Bounty_The_Legend"
	einfo "https://www.greenmangaming.com/games/kings-bounty-the-legend"
	einfo "https://store.epicgames.com/en-US/p/kings-bounty-the-legend-b69320"
	einfo "https://www.humblebundle.com/store/kings-bounty-the-legend"
	einfo ""
	einfo "The game is installed to /opt/$PN - if you want to run it by another Wine or operating system"
}
