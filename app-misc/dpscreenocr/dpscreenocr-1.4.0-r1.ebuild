# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Program to recognize text on screen"
HOMEPAGE="https://danpla.github.io/dpscreenocr/"
SRC_URI="https://github.com/danpla/dpscreenocr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# Add Qt and Xorg dependencies too
RDEPEND="
	app-text/tesseract:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-libs/libX11
	x11-libs/libXext
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DDPSO_GEN_HTML_MANUAL=OFF
	)
	cmake_src_configure
}

src_install() {
	# the following installs non sense :
	#cmake_src_install
	dobin "${BUILD_DIR}/dpscreenocr"
	domenu "${BUILD_DIR}/dpscreenocr.desktop"
	dolib.so "${BUILD_DIR}/src/dpso/libdpso.so"
	dolib.so "${BUILD_DIR}/src/dpso_ext/libdpso_ext.so"
	dolib.so "${BUILD_DIR}/src/dpso_utils/libdpso_utils.so"
}
