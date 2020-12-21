# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg cmake

DESCRIPTION="Ksnip is a Qt based cross-platform screenshot tool"
HOMEPAGE="https://github.com/ksnip/ksnip"
SRC_URI="https://github.com/ksnip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
		dev-qt/qtdbus:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
		>=x11-libs/kimageannotator-0.4.0
		x11-libs/libxcb
"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules:5"

src_install() {
	cmake_src_install
	doicon -s scalable desktop/${PN}.svg
	domenu desktop/org.${PN}.${PN}.desktop
}
