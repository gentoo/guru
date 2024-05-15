# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cursor set highly inspired on KDE Breeze with HiDPi Support"
HOMEPAGE="https://github.com/ful1e5/BreezeX_Cursor"
SRC_URI="
	https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${PV}/BreezeX-Black.tar.gz -> ${P}-black.tar.gz
	https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${PV}/BreezeX-Dark.tar.gz -> ${P}-dark.tar.gz
	https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${PV}/BreezeX-Light.tar.gz -> ${P}-light.tar.gz
	"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXcursor"

src_install() {
	insinto /usr/share/cursors/xorg-x11
	doins -r BreezeX-{Black,Dark,Light}
}
