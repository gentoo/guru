# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake virtualx xdg

COMMIT="1e2d6785c2f0650730065cba545156cd1d50c66b"

DESCRIPTION="Ksnip is a Qt based cross-platform screenshot tool"
HOMEPAGE="https://github.com/ksnip/ksnip"
SRC_URI="https://github.com/ksnip/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets,xml]
	dev-qt/qtsvg:6
	>=media-libs/kcolorpicker-0.3.0
	>=media-libs/kimageannotator-0.7.1
	x11-libs/libX11
	x11-libs/libxcb:=
"
DEPEND="${RDEPEND}
	dev-qt/qtbase:6[concurrent]
	kde-frameworks/extra-cmake-modules
	test? ( dev-cpp/gtest )
"
BDEPEND="
	dev-qt/qttools:6[linguist]
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DBUILD_WITH_QT6=ON
	)
	cmake_src_configure
}

src_test() {
	local BUILD_DIR="${BUILD_DIR}/tests"
	virtx cmake_src_test
}
