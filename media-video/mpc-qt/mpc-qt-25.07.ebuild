# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Media Player Classic Qute Theater"
HOMEPAGE="https://mpc-qt.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6[dbus,gui,network,opengl,wayland,widgets]
	dev-qt/qtsvg:6
	media-video/mpv:=[libmpv]
"
DEPEND="
	${RDEPEND}
	dev-libs/boost
"
BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare

	# drop forced optimization
	sed -i -e "s/ -O2//" \
		-e "s|share/doc/${PN}|share/doc/${PF}|" \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DMPCQT_VERSION="${PV}"
	)
	cmake_src_configure
}
