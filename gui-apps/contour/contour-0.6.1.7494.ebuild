# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Modern C++ Terminal Emulator"
HOMEPAGE="https://contour-terminal.org/ https://github.com/contour-terminal/contour"
SRC_URI="https://github.com/contour-terminal/contour/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-cpp/boxed-cpp
	dev-cpp/ms-gsl
	dev-cpp/range-v3
	dev-cpp/reflection-cpp
	dev-cpp/yaml-cpp:=
	dev-qt/qtbase:6[opengl]
	dev-qt/qt5compat
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	media-libs/freetype
	media-libs/harfbuzz:=
	media-libs/libunicode
	sys-libs/libutempter

	test? (
		dev-cpp/catch:0
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCCACHE=Off
		-DCONTOUR_TESTING=$(usex test)
		-DCONTOUR_PACKAGE_TERMINFO=OFF
	)

	cmake_src_configure
}
