# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake virtualx

DESCRIPTION="Tray application and Dolphin/Plasma integration for Syncthing"
HOMEPAGE="https://github.com/Martchus/syncthingtray"

SRC_URI="https://github.com/Martchus/syncthingtray/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kio plasmoid test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/boost
	dev-qt/qtbase:6[concurrent,network]
	dev-qt/qtsvg:6
	gui-libs/qtforkawesome[qt6(+)]
	gui-libs/qtutilities[qt6(+)]
	kio? ( kde-frameworks/kio:6 )
	plasmoid? ( kde-plasma/libplasma:6 )
"
RDEPEND="$DEPEND
	net-p2p/syncthing
"
BDEPEND="
	test? (
		dev-util/cppunit
		net-p2p/syncthing
	)
	plasmoid? ( kde-frameworks/extra-cmake-modules )
"

src_configure() {
	local mycmakeargs=(
		-DCONFIGURATION_PACKAGE_SUFFIX_QTUTILITIES=-qt6
		-DQT_PACKAGE_PREFIX=Qt6
		-DKF_PACKAGE_PREFIX=KF6
		-DNO_FILE_ITEM_ACTION_PLUGIN=$(usex !kio)
		-DNO_PLASMOID=$(usex !plasmoid)
		-DEXCLUDE_TESTS_FROM_ALL=$(usex !test)
	)
	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
