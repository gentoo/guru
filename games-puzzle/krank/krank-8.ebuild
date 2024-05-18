# Copyright 2016-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="Little casual game"
HOMEPAGE="https://gitlab.com/mazes_80/krank"
SRC_URI="https://gitlab.com/mazes_80/krank/-/archive/${PV}/${P}.tar.bz2"


LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pygame"

src_install() {
	dobin krank
	insinto /usr/share/${PN}/
	doins -r src sounds levels fonts art
	make_desktop_entry ${PN} "Krank" "/usr/share/${PN}/levels/images/icon64x64.png"
}
