# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Quite universal circuit simulator with SPICE"
HOMEPAGE="https://ra3xdh.github.io/"
SRC_URI="https://github.com/ra3xdh/qucs_s/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

inherit cmake xdg optfeature

DEPEND="
	dev-qt/qtbase:6[gui,widgets,xml]
	dev-qt/qtsvg:6
	dev-qt/qtcharts:6
	"

RDEPEND="
	${DEPEND}
	"

BDEPEND="
	dev-qt/qttools:6[linguist]
	sys-devel/flex
	sys-devel/bison
	dev-util/gperf
	app-text/dos2unix
	"

pkg_postinst() {
	optfeature "Result postprocessing in Octave" sci-mathematics/octave

	optfeature_header "Install optional simulator backends:"
	optfeature "Ngspice" sci-electronics/ngspice

	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
