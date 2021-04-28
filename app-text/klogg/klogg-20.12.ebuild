# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="A GUI application to browse and search through long and complex log files"
HOMEPAGE="https://klogg.filimonov.dev"
SRC_URI="https://github.com/variar/klogg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+sentry lto"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtconcurrent:5
"
RDEPEND="
	${DEPEND}
	x11-themes/hicolor-icon-theme
"

QA_PREBUILT="usr/bin/klogg_minidump_dump"

src_prepare() {
	sed -e 's|share/doc/klogg|${CMAKE_INSTALL_DOCDIR}|' -i "${S}/CMakeLists.txt" || die "sed CMAKE_INSTALL_DOCDIR"
	sed -e 's|TBB_INSTALL_LIBRARY_DIR lib|TBB_INSTALL_LIBRARY_DIR ${CMAKE_INSTALL_LIBDIR}|' -i "${S}/3rdparty/tbb/CMakeLists.txt" || die "sed TBB_INSTALL_LIBRARY_DIR"
	cmake_src_prepare
}

src_configure() {
	export KLOGG_VERSION=${PV}.0.813
	local mycmakeargs=(
		-DDISABLE_WERROR=ON
		-DKLOGG_USE_SENTRY=$(usex sentry)
		-DUSE_LTO=$(usex lto)
		-DWARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}
