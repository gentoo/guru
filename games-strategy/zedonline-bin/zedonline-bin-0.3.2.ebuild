# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="A remake of the 1996 classic game Z, with network play"
HOMEPAGE="https://sourceforge.net/projects/zedonline/"
SRC_URI="https://master.dl.sourceforge.net/project/zedonline/releases/ZED%20Online%20v$PV%20Linux.zip"

S="$WORKDIR"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

BDEPEND="
	app-arch/unzip
"

src_install() {
	P="$ED/opt/zedonline"
	mkdir -p $P|| die
	cp -r . "$ED/opt/zedonline/" || die

	make_wrapper $PN "'./ZED Online'" /opt/$PN/
}

pgk_postinst() {
	einfo "See the game guide at https://zzone.lewe.com/commander-zod-single-player-guide"
}
