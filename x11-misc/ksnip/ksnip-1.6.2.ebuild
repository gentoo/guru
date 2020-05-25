# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop

DESCRIPTION="Ksnip is a Qt based cross-platform screenshot tool"
HOMEPAGE="https://github.com/ksnip/ksnip"
SRC_URI="https://github.com/ksnip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules:5"
RDEPEND="
		dev-qt/qtdbus:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
		x11-libs/kimageannotator
		x11-libs/libxcb"
BDEPEND=""

src_install() {
	cmake_src_install

	doicon -s scalable desktop/${PN}.svg
	domenu desktop/${PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
