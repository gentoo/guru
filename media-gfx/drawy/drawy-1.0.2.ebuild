# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN="6.19.0"
QTMIN="6.10.0"
KDE_ORG_COMMIT="0974febca42e3722b77dbb150967ee4bfab064a8" # it is tagged but no release
inherit kde.org ecm xdg

DESCRIPTION="Your handy, infinite brainstorming tool!"
HOMEPAGE="https://apps.kde.org/drawy/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# order the kf depends in the order of which they get manged in the CMakeLists.txt
DEPEND="
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/syntax-highlighting-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6
"
RDEPEND="${DEPEND}"
