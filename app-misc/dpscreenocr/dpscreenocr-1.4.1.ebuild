# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Program to recognize text on screen"
HOMEPAGE="https://danpla.github.io/dpscreenocr/"
SRC_URI="https://github.com/danpla/dpscreenocr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# Add Qt and Xorg dependencies too
RDEPEND="
	app-text/tesseract:=
	dev-qt/qtbase:6[gui,widgets]
	x11-libs/libX11
	x11-libs/libXext
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DDPSO_GEN_HTML_MANUAL=OFF
		-DDPSO_QT_VERSION=6
	)
	cmake_src_configure
}
