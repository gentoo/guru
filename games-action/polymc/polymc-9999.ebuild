# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 java-pkg-2 optfeature xdg

HOMEPAGE="https://polymc.org/"
DESCRIPTION="A custom, open source Minecraft launcher"

EGIT_REPO_URI="
	https://github.com/PolyMC/PolyMC
	https://github.com/MultiMC/libnbtplusplus
	https://github.com/stachenov/quazip
"

# GPL-3 for PolyMC
# LGPL-3 for libnbtplusplus
# LGPL-2.1 with linking exception for Quazip
LICENSE="GPL-3 LGPL-3 LGPL-2.1-with-linking-exception"

SLOT="0"

IUSE="debug"

QT_DEPS="
	>=dev-qt/qtcore-5.6.0:5
	>=dev-qt/qttest-5.6.0:5
	>=dev-qt/qtconcurrent-5.6.0:5
	>=dev-qt/qtgui-5.6.0:5
	>=dev-qt/qtnetwork-5.6.0:5
	>=dev-qt/qtwidgets-5.6.0:5
	>=dev-qt/qtxml-5.6.0:5
"

BDEPEND="
	${QT_DEPS}
	sys-libs/zlib
	>=virtual/jdk-1.8.0:*
	media-libs/libglvnd
"

DEPEND="
	${QT_DEPS}
	>=virtual/jre-1.8.0:*
	virtual/opengl
"

RDEPEND="${DEPEND}"

src_prepare() {
	if ${PV} != 9999; then
		EGIT_COMMIT="${PV}"
	fi

	git submodule init
	git config submodule.libnbtplusplus.url "${WORKDIR}/libnbtplusplus"
	git config submodule.quazip.url "${WORKDIR}/quazip"
	git submodule update

	default
	cmake_src_prepare
}

src_configure(){
	if use debug; then
		CMAKE_BUILD_TYPE=Debug
	else
		CMAKE_BUILD_TYPE=Release
	fi

	local mycmakeargs=(
		-DLauncher_PORTABLE=0
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DLauncher_APP_BINARY_NAME="${PN}"
	)
	cmake_src_configure
}

src_compile(){
	cmake_src_compile
}

pkg_postinst() {
	xdg_pkg_postinst

	# https://github.com/PolyMC/PolyMC/issues/227
	optfeature "old Minecraft (<= 1.12.2) support" x11-libs/libXrandr
}
