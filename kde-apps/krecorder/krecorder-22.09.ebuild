# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.89.0
QTMIN=5.15.0
inherit ecm

DESCRIPTION="A convergent audio recording application for Plasma"
HOMEPAGE="https://apps.kde.org/krecorder/"
SRC_URI="mirror://kde/stable/plasma-mobile/${PV}/${P}.tar.xz"

LICENSE="CC-BY-4.0 GPL-3+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
"
DEPEND="${RDEPEND}
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
"
