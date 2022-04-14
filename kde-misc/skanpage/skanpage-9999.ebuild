# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="utilities"
if [[ ${PV} != 9999 ]]; then
	KDE_ORG_COMMIT="6edb4961b5f0f3fc417580c55e3fcbbadcba4543"
	KEYWORDS="~amd64"
fi
KFMIN=5.91
QTMIN=5.15.2
inherit ecm kde.org

DESCRIPTION="Multi-page scanning application supporting image and pdf files"
HOMEPAGE="https://invent.kde.org/utilities/skanpage"

LICENSE="|| ( GPL-2 GPL-3 ) CC0-1.0"
SLOT="5"

DEPEND="
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-apps/libksane-21.12.3:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kjobwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
RDEPEND="${DEPEND}"
