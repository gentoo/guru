# Copyright 2026 Dimitris Trivizakis
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Terminal tool for visualizing hard disk usage"
HOMEPAGE="https://github.com/JimiGR1/ncursys"
SRC_URI="https://github.com/JimiGR1/ncursys/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	sys-libs/ncurses:=[tinfo]
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
