# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

MY_PV="v$(ver_cut 1-2)"

DESCRIPTION="Cursor theme using a custom color palette inspired by boreal colors"
HOMEPAGE="https://github.com/alvatip/Neonly"
SRC_URI="https://github.com/alvatip/Neonly/releases/download/${MY_PV}/Neonly.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

src_install() {
	insinto "/usr/share/icons/${PN}"
	doins -r cursors index.theme
}
