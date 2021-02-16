# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit xdg qmake-utils

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://github.com/jurplel/qView"

SRC_URI="https://github.com/jurplel/qView/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtgui:5"

BDEPEND=""

RDEPEND="${DEPEND}"

S="${WORKDIR}/qView-${PV}"

src_configure() {
	eqmake5 PREFIX=/usr qView.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
