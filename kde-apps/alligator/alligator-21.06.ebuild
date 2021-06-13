# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
KFMIN=5.75.0
QTMIN=5.15.0
inherit ecm

DESCRIPTION="A convergent RSS/Atom feed reader for Plasma"
HOMEPAGE="https://apps.kde.org/alligator/"
SRC_URI="mirror://kde/stable/plasma-mobile/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/syndication-${KFMIN}:5
"
RDEPEND="${DEPEND}"
