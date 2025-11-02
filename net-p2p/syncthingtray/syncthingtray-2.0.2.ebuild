# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Tray application and Dolphin/Plasma integration for Syncthing"
HOMEPAGE="https://github.com/Martchus/syncthingtray"

SRC_URI="https://github.com/Martchus/syncthingtray/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kio plasmoid +qt6 test"
REQUIRED_USE="
	plasmoid? ( qt6 )
"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/boost
	!qt6? (
		dev-qt/qtconcurrent:5
		dev-qt/qtnetwork:5
		dev-qt/qtsvg:5
		gui-libs/qtforkawesome[qt5]
		gui-libs/qtutilities[qt5]
		kio? ( kde-frameworks/kio:5 )
	)
	qt6? (
		dev-qt/qtbase:6[concurrent,network]
		dev-qt/qtsvg:6
		gui-libs/qtforkawesome[qt6]
		gui-libs/qtutilities[qt6]
		kio? ( kde-frameworks/kio:6 )
		plasmoid? ( kde-plasma/libplasma:6 )
	)
	"
RDEPEND="$DEPEND
	net-p2p/syncthing
"
BDEPEND="
	qt6? (
		plasmoid? ( kde-frameworks/extra-cmake-modules )
	)
"

src_configure() {
	local mycmakeargs=(
		-DCONFIGURATION_PACKAGE_SUFFIX_QTUTILITIES=-$(usex !qt6 qt5 qt6)
		-DQT_PACKAGE_PREFIX=$(usex !qt6 Qt5 Qt6)
		-DKF_PACKAGE_PREFIX=$(usex !qt6 KF5 KF6)
		-DNO_FILE_ITEM_ACTION_PLUGIN=$(usex !kio)
		-DNO_PLASMOID=$(usex !plasmoid)
		-DEXCLUDE_TESTS_FROM_ALL=$(usex !test)
	)
	cmake_src_configure
}
