# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit desktop cmake

DESCRIPTION="Program to recognize text on screen"
HOMEPAGE="https://danpla.github.io/dpscreenocr/"
SRC_URI="https://github.com/danpla/dpscreenocr/archive/refs/tags/v${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# Add Qt and Xorg dependencies too
RDEPEND="app-text/tesseract
	 x11-libs/libXext
	 dev-qt/qtcore:5"
DEPEND="${RDEPEND}"

src_configure() {
        local mycmakeargs=(
                '-DCMAKE_BUILD_TYPE=Release'
        )
        cmake_src_configure
}

src_install() {
	# the following installs non sense :
	#cmake_src_install
	dobin "${WORKDIR}/${P}_build/dpscreenocr"
	domenu "${WORKDIR}/${P}_build/dpscreenocr.desktop"
	dolib.so "${WORKDIR}/${P}_build/src/dpso/libdpso.so"
	dolib.so "${WORKDIR}/${P}_build/src/dpso_ext/libdpso_ext.so"
	dolib.so "${WORKDIR}/${P}_build/src/dpso_utils/libdpso_utils.so"
}
