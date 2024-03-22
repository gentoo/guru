# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Singleplayer demo of Armies of Exigo (like WarCraft III), Windows"
HOMEPAGE="https://en.wikipedia.org/wiki/Armies_of_Exigo"

SRC_URI="https://archive.org/download/armies-of-exigo--single-player-demo--portable-without-installer.tar/armies-of-exigo--single-player-demo--portable-without-installer.tar.xz"
# TODO add multiplayer demo

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	~games-emulation/conty-1.25.2:0
"

QA_PREBUILT="*"

dir=/opt/armies-of-exigo

src_install() {

	conty=conty-1.25.2

	single=armies-of-exigo-demo-single

	mkdir -p "$ED"/opt/armies-of-exigo

	name=armies-of-exigo--single-player-demo--portable-without-installer

	cp -r "$name" "$ED"/opt/armies-of-exigo/singleplayer-demo

	path="$dir/singleplayer-demo/Exigo_spdemo.exe"
	make_wrapper "$single" "$conty wine \"$path\""
	# TODO add USE flag to be able to choolse local wine or wine-proton, against 1.4 GB dependency?

}

pkg_postinst() {
	einfo "More about the game:"
	einfo "https://en.wikipedia.org/wiki/Armies_of_Exigo"
	einfo "Discord: https://discord.gg/HcsjkNX3JY"
	einfo "https://armies-of-exigo.fandom.com/wiki/Armies_of_Exigo_Wiki"
	einfo ""
	einfo "This great game from 2004 is an abandonware - in 2024 you can buy it only as a second-hand CD."
	einfo "List of creators: https://www.mobygames.com/game/16100/armies-of-exigo/credits/windows/"
	einfo "If you want - please try to communicate with authors about making Armies of Exigo free and open source,"
	einfo "or Intellectual Property holder can make a remake - add more display resolutions, improve the AI,"
	einfo "make it runnable on modern Windows."
	einfo ""
	einfo "The game is installed to $dir - if you want to run it by another Wine"
}
