# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_REMOVE_MODULES_LIST=( BackwardConfig )
inherit cmake optfeature virtualx xdg

DESCRIPTION="High-level runtime introspection tool for Qt applications"
HOMEPAGE="https://www.kdab.com/gammaray https://github.com/KDAB/GammaRay"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KDAB/GammaRay.git"
else
	SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2 GPL-2+ MIT"
SLOT=0

IUSE="3d bluetooth designer doc geolocation printsupport script scxml svg test qml wayland webengine"
RESTRICT="!test? ( test )"

# TODO: fix automagic sci-libs/vtk (and many other) dependencies
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kitemmodels:5
	3d? ( dev-qt/qt3d:5 )
	bluetooth? ( dev-qt/qtbluetooth:5 )
	designer? ( dev-qt/designer:5 )
	geolocation? ( dev-qt/qtpositioning:5 )
	printsupport? ( dev-qt/qtprintsupport:5 )
	qml? ( dev-qt/qtdeclarative:5[widgets] )
	script? ( dev-qt/qtscript:5[scripttools] )
	scxml? ( dev-qt/qtscxml:5 )
	svg? ( dev-qt/qtsvg:5 )
	webengine? ( dev-qt/qtwebengine:5[widgets] )
	wayland? ( dev-qt/qtwayland:5 )
"

DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
"

DOCS=( CHANGES CONTRIBUTORS.txt README.txt )

PATCHES=( "${FILESDIR}"/${P}-deselect-tests.patch )

src_prepare(){
	sed -i "/add_backward(gammaray_core)/d" core/CMakeLists.txt || die
	sed -i CMakeLists.txt  \
		-e "/BackwardConfig.cmake/d" \
		-e "/set(KDE_INSTALL_USE_QT_SYS_PATHS/d" || die

	cmake_src_prepare
}

src_configure(){
	local mycmakeargs=(
		$(cmake_use_find_package 3d Qt53DAnimation)
		$(cmake_use_find_package 3d Qt53DExtras)
		$(cmake_use_find_package 3d Qt53DInput)
		$(cmake_use_find_package 3d Qt53DLogic)
		$(cmake_use_find_package 3d Qt53DRender)
		$(cmake_use_find_package 3d Qt53DQuick)
		$(cmake_use_find_package bluetooth Qt5Bluetooth)
		$(cmake_use_find_package designer Qt5Designer)
		$(cmake_use_find_package geolocation Qt5Positioning)
		$(cmake_use_find_package printsupport Qt5PrintSupport)
		$(cmake_use_find_package qml Qt5Qml)
		$(cmake_use_find_package qml Qt5Quick)
		$(cmake_use_find_package qml Qt5QuickWidgets)
		$(cmake_use_find_package script Qt5Script)
		$(cmake_use_find_package svg Qt5Svg)
		$(cmake_use_find_package scxml Qt5Scxml)
		$(cmake_use_find_package test Qt5Test)
		$(cmake_use_find_package wayland Qt5WaylandCompositor)
		$(cmake_use_find_package webengine Qt5WebEngineWidgets)
		-DGAMMARAY_BUILD_DOCS=$(usex doc)
		-DGAMMARAY_BUILD_UI=ON
		-DGAMMARAY_DISABLE_FEEDBACK=ON
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
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

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "graphical state machine debugging support" dev-util/kdstatemachineeditor
}
