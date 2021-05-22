# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_DEBUG="false"
KFMIN=5.80
QTMIN=5.15.2
inherit ecm

COMMIT="1c144786d44ec266839ff3ffbe911f2cc61644d1"

DESCRIPTION="Simple pdf scanning application based on libksane and KDE Frameworks"
HOMEPAGE="https://invent.kde.org/utilities/skanpage"
SRC_URI="https://invent.kde.org/utilities/skanpage/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="5"
KEYWORDS="~amd64"

DEPEND="
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-apps/libksane-19.04.0:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kjobwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"
