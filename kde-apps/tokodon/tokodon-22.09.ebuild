# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.77.0
QTMIN=5.15.0
inherit ecm

DESCRIPTION="Mastodon client for Plasma and Plasma Mobile"
HOMEPAGE="https://invent.kde.org/network/tokodon"
SRC_URI="mirror://kde/stable/plasma-mobile/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtwebsockets-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:5
"
DEPEND="${RDEPEND}
	dev-libs/qtkeychain[qt5(+)]
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
"
