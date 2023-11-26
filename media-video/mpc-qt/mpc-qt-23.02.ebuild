# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop

DESCRIPTION="Media Player Classic Qute Theater"
HOMEPAGE="https://mpc-qt.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtcore:5"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	eqmake5 mpc-qt.pro
}

src_compile() {
	emake
}

src_install() {
	dobin "${WORKDIR}/${P}/mpc-qt"
	domenu "${WORKDIR}/${P}/io.github.mpc_qt.Mpc-Qt.desktop"
}
