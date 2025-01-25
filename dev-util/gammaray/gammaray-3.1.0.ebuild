# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake qmake-utils virtualx xdg

DESCRIPTION="High-level runtime introspection tool for Qt applications"
HOMEPAGE="
	https://www.kdab.com/software-technologies/developer-tools/gammaray/
	https://github.com/KDAB/GammaRay
"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KDAB/GammaRay.git"
else
	SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2 GPL-2+ MIT"
SLOT=0

IUSE="3d bluetooth designer doc geolocation scxml svg test qml wayland webengine"
RESTRICT="!test? ( test )"

# TODO: fix automagic sci-libs/vtk (and many other) dependencies
RDEPEND="
	dev-qt/qtbase:6[concurrent,gui,network,widgets,xml]
	kde-frameworks/kitemmodels:6
	3d? ( dev-qt/qt3d:6 )
	bluetooth? ( dev-qt/qtconnectivity:6[bluetooth] )
	designer? ( dev-qt/qttools:6[designer] )
	geolocation? ( dev-qt/qtpositioning:6 )
	qml? ( dev-qt/qtdeclarative:6[widgets] )
	scxml? ( dev-qt/qtscxml:6 )
	svg? ( dev-qt/qtsvg:6 )
	wayland? (
		dev-libs/wayland
		dev-qt/qtwayland:6[compositor]
	)
	webengine? ( dev-qt/qtwebengine:6[widgets] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/perl
	doc? (
		app-text/doxygen[dot]
		dev-qt/qttools:6[assistant,linguist,qdoc]
	)
"

PATCHES=( "${FILESDIR}"/${P}-deselect-tests.patch )

src_prepare() {
	sed -i "/add_backward(gammaray_core)/d" core/CMakeLists.txt || die
	sed -i "/BackwardConfig.cmake/d" CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package 3d Qt63DAnimation)
		$(cmake_use_find_package 3d Qt63DExtras)
		$(cmake_use_find_package 3d Qt63DInput)
		$(cmake_use_find_package 3d Qt63DLogic)
		$(cmake_use_find_package 3d Qt63DRender)
		$(cmake_use_find_package 3d Qt63DQuick)
		$(cmake_use_find_package bluetooth Qt6Bluetooth)
		$(cmake_use_find_package designer Qt6Designer)
		$(cmake_use_find_package doc Doxygen)
		$(cmake_use_find_package geolocation Qt6Positioning)
		$(cmake_use_find_package qml Qt6Qml)
		$(cmake_use_find_package qml Qt6Quick)
		$(cmake_use_find_package qml Qt6QuickWidgets)
		$(cmake_use_find_package svg Qt6Svg)
		$(cmake_use_find_package scxml Qt6Scxml)
		$(cmake_use_find_package scxml Qt6StateMachine)
		$(cmake_use_find_package wayland Qt6WaylandCompositor)
		$(cmake_use_find_package webengine Qt6WebEngineWidgets)
		-DBUILD_TESTING=$(usex test)
		-DECM_MKSPECS_INSTALL_DIR="$(qt6_get_mkspecsdir)"
		-DGAMMARAY_BUILD_DOCS=ON
		-DGAMMARAY_BUILD_UI=ON
		-DGAMMARAY_DISABLE_FEEDBACK=ON
		-DQT_VERSION_MAJOR=6
	)

	cmake_src_configure
}

src_test() {
# 	export QT_QPA_PLATFORM=offscreen
	virtx cmake_src_test
}

src_install() {
	cmake_src_install
	rm -r "${ED}"/usr/share/doc/${PN} || die
}
