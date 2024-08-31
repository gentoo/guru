# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://github.com/jurplel/qView https://interversehq.com/qview/"
SRC_URI="https://github.com/jurplel/qView/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qView-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X"

RDEPEND="
	dev-qt/qtbase:6[concurrent,gui,network,widgets]
	X? ( x11-libs/libX11 )
"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-qt/qttools[linguist]
"

src_configure() {
	local myqmakeargs=(
		PREFIX="${EPREFIX}"/usr
		$(usex X '' CONFIG+=NO_X11)
	)
	eqmake6 "${myqmakeargs[@]}"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
