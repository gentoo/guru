# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# skip warning for unused files in 3rdparty/backward-cpp
CMAKE_QA_COMPAT_SKIP=1

inherit cmake qmake-utils xdg

MY_PN="GammaRay"
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
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="BSD-2 GPL-2+ MIT"
SLOT=0

IUSE="3d bluetooth designer doc geolocation highlight kjob scxml svg test wayland webengine"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/elfutils
	dev-qt/qtbase:6[concurrent,gui,network,widgets,xml]
	dev-qt/qtdeclarative:6[widgets]
	3d? ( dev-qt/qt3d:6[qml] )
	bluetooth? ( dev-qt/qtconnectivity:6[bluetooth] )
	designer? ( dev-qt/qttools:6[designer] )
	geolocation? (
		dev-qt/qtlocation:6
		dev-qt/qtpositioning:6
	)
	highlight? ( kde-frameworks/syntax-highlighting:6 )
	kjob? ( kde-frameworks/kcoreaddons:6 )
	scxml? (
		dev-qt/qtscxml:6
		>=dev-util/kdstatemachineeditor-2.2.0
	)
	svg? ( dev-qt/qtsvg:6 )
	wayland? (
		dev-libs/wayland
		dev-qt/qtwayland:6[compositor(+)]
	)
	webengine? ( dev-qt/qtwebengine:6[widgets] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/perl
	dev-qt/qttools:6[linguist]
	doc? (
		app-text/doxygen
		dev-qt/qttools:6[assistant,qdoc,qtattributionsscanner]
		media-gfx/graphviz
	)
	wayland? ( dev-util/wayland-scanner )
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.3.0-unbundle_libs.patch
)

src_prepare() {
	cmake_src_prepare

	if ! use doc; then
		cmake_comment_add_subdirectory -f docs manual api collection
	fi
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
		$(cmake_use_find_package geolocation Qt6Location)
		$(cmake_use_find_package geolocation Qt6Positioning)
		$(cmake_use_find_package highlight KF6SyntaxHighlighting)
		$(cmake_use_find_package kjob KF6CoreAddons)
		$(cmake_use_find_package svg Qt6Svg)
		$(cmake_use_find_package scxml Qt6Scxml)
		$(cmake_use_find_package scxml Qt6StateMachine)
		$(cmake_use_find_package wayland Qt6WaylandCompositor)
		$(cmake_use_find_package wayland Wayland)
		$(cmake_use_find_package webengine Qt6WebEngineWidgets)
		-DBUILD_TESTING=$(usex test)
		-DECM_MKSPECS_INSTALL_DIR="$(qt6_get_mkspecsdir)"
		# enable doc for manpages
		-DGAMMARAY_BUILD_DOCS=ON
		-DGAMMARAY_BUILD_UI=ON
		-DGAMMARAY_DISABLE_FEEDBACK=ON
		-DGAMMARAY_WITH_KDSME=$(usex scxml)
		-DQT_VERSION_MAJOR=6
	)

	cmake_src_configure
}

src_test() {
	local CMAKE_SKIP_TESTS=(
		# avoid gdb/lldb tests
		connectiontest-*
		connectiontest-*-filter
		# GammaRay::ProblemReporterTest::testConnectionIssues() We can't find duplicates with PMF connects, yet.
		problemreportertest
		# QFATAL : QuickInspectorTest::testModelsReparent() Failed to initialize graphics backend for OpenGL.
		quickinspectortest
		quickinspectortest2
		# need gdb/lldb
		# Yama security extension is blocking runtime attaching
		clientconnectiontest
		launchertest
		# need launcher
		quickmaterialtest
		quicktexturetest
	)
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}

src_install() {
	if use doc; then
		local HTML_DOCS=( "${BUILD_DIR}"/docs/api/html/. )
		find "${HTML_DOCS}" \( -iname '*.map' -o -iname '*.md5' \) -delete || die
	fi

	cmake_src_install

	docompress -x /usr/share/doc/${PF}/${PN}{.qhc,-manual.qch,-api.qch}
	rm -r "${ED}"/usr/share/doc/${PN} || die
}
