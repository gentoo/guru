# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Opensource, compact, and material-designed cursor set"
HOMEPAGE="https://github.com/ful1e5/Bibata_Cursor"
SRC_URI="https://github.com/ful1e5/Bibata_Cursor/releases/download/v${PV}/Bibata.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXcursor"

src_install() {
	insinto /usr/share/cursors/xorg-x11
	doins -r Bibata-{Modern,Original}-{Amber,Classic,Ice}
}
