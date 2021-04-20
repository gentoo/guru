# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_DEBUG="false"
KFMIN=5.74.0
QTMIN=5.14.2
inherit ecm desktop

COMMIT="b265d4c7fc2cc33e85ded01763486b2be1d4a42e"

DESCRIPTION="Simple pdf scanning application based on libksane and KDE Frameworks"
HOMEPAGE="https://invent.kde.org/astippich/skanpage"
SRC_URI="https://invent.kde.org/astippich/skanpage/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz -> ${P}.tar.gz"

# No license in repo
RESTRICT="bindist mirror"
LICENSE="all-rights-reserved"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-apps/libksane-19.04.0:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kjobwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"
