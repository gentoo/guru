# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Media Player Classic Qute Theater"
HOMEPAGE="https://mpc-qt.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,opengl,widgets]
	media-video/mpv:=[libmpv]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_prepare() {
	default

	sed -i "s|doc/mpc-qt/|doc/${PF}|" mpc-qt.pro || die
}

src_configure() {
	eqmake6 MPCQT_VERSION="${PV}" PREFIX="${EPREFIX}/usr" mpc-qt.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
