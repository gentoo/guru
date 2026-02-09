# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.18.0
QTMIN=6.9.0

inherit cmake git-r3 xdg

DESCRIPTION="Klassy QT6 window decoration theme for KDE Plasma 6.5+"
HOMEPAGE="https://github.com/paulmcauley/klassy"
EGIT_REPO_URI="https://github.com/paulmcauley/klassy"
EGIT_BRANCH="master"

LICENSE="GPL-2 GPL-2+ GPL-3 GPL-3+ LGPL-2.1+ MIT"
SLOT="0"
# Testing is unsupported in upstream.
RESTRICT="test"

DEPEND=">=dev-qt/qtbase-${QTMIN}:6[dbus,widgets,xml]
		>=dev-qt/qtdeclarative-${QTMIN}:6
		>=dev-qt/qtsvg-${QTMIN}:6
		>=kde-frameworks/extra-cmake-modules-${KFMIN}
		>=kde-frameworks/frameworkintegration-${KFMIN}:6
		>=kde-frameworks/kcmutils-${KFMIN}:6
		>=kde-frameworks/kcolorscheme-${KFMIN}:6
		>=kde-frameworks/kconfig-${KFMIN}:6
		>=kde-frameworks/kcoreaddons-${KFMIN}:6
		>=kde-frameworks/kguiaddons-${KFMIN}:6
		>=kde-frameworks/ki18n-${KFMIN}:6
		>=kde-frameworks/kiconthemes-${KFMIN}:6
		>=kde-frameworks/kirigami-${KFMIN}:6
		>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
		>=kde-frameworks/kwindowsystem-${KFMIN}:6
		kde-plasma/kdecoration:6
"
RDEPEND="${DEPEND}
		 x11-misc/xdg-utils"

src_configure() {
	local mycmakeargs=(
		"-DBUILD_QT5=OFF"
		"-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
		"-DBUILD_TESTING=OFF"
	)

	cmake_src_configure
}
