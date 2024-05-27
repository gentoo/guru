# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://github.com/jurplel/qView https://interversehq.com/qview/"
SRC_URI="https://github.com/jurplel/qView/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qView-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase[concurrent,gui,network,widgets]
"

DEPEND="${RDEPEND}
"

BDEPEND="
	dev-qt/qttools[linguist]
"

src_configure() {
	eqmake6 PREFIX=/usr qView.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
