# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg cmake
# cmake has to be listed after xdg for src_prepare to work

DESCRIPTION="Ksnip is a Qt based cross-platform screenshot tool"
HOMEPAGE="https://github.com/ksnip/ksnip"
SRC_URI="https://github.com/ksnip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5[png]
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	>=media-libs/kcolorpicker-0.1.6
	>=media-libs/kimageannotator-0.5.3
	x11-libs/libX11
	x11-libs/libxcb"
DEPEND="${RDEPEND}
	dev-qt/qtconcurrent:5
	kde-frameworks/extra-cmake-modules
"
BDEPEND="
	dev-qt/linguist-tools:5
"

src_install() {
	cmake_src_install

	doicon -s scalable desktop/${PN}.svg
	domenu desktop/org.${PN}.${PN}.desktop
}
