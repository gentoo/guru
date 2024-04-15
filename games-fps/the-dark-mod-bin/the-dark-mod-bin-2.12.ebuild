# Copyright 2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Inspired by Thief on Doom 3 libre engine (id Tech 4)"
HOMEPAGE="
	https://www.thedarkmod.com
	https://en.wikipedia.org/wiki/The_Dark_Mod
"
SRC_URI="https://archive.org/download/the-dark-mod/the-dark-mod-$PV.tar.xz"

LICENSE="
	GPL-3
	CC-BY-NC-ND-3.0
"

SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"
RESTRICT="strip"

S="${WORKDIR}/the-dark-mod"

src_install() {
	dodir /opt
	dodir /usr/bin/

	cp -r . "$ED/opt/$PN" || die

	echo "cd /opt/$PN; ./thedarkmod.x64; cd -" > "$ED/usr/bin/$PN"
	fperms +x "/usr/bin/$PN"
}
