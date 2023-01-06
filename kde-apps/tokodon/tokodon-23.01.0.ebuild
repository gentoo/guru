# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.77.0
QTMIN=5.15.0
ECM_TEST=optional
inherit ecm

DESCRIPTION="Mastodon client for Plasma and Plasma Mobile"
HOMEPAGE="https://invent.kde.org/network/tokodon"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"

LICENSE="|| ( GPL-2 GPL-3 ) AGPL-3+ CC-BY-SA-4.0 CC0-1.0 GPL-2+ GPL-3 GPL-3+ LGPL-2+ LGPL-2.1+ MIT"
SLOT="5"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/kirigami-addons-0.6:5
	dev-libs/qtkeychain[qt5(+)]
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwebsockets-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:5
	>=kde-frameworks/sonnet-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	ecm_src_test
}
