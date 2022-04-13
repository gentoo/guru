# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Spreadsheet Calculator Improvised -- An ncurses spreadsheet program for terminal"
HOMEPAGE="https://github.com/andmarti1424/sc-im"
SRC_URI="https://github.com/andmarti1424/sc-im/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X plots xls lua ods"

PATCHES=(
	"${FILESDIR}/${P}-prefix.patch"
)

DEPEND="
	sys-libs/ncurses
	X? ( || ( app-misc/tmux x11-misc/xclip ) )
	plots? ( sci-visualization/gnuplot )
	xls? (
		dev-libs/libxlsxwriter
		dev-haskell/libxml
		dev-libs/libzip
		dev-libs/libxls
	)
	lua? (
		dev-lang/lua
	)
	ods? (
		dev-libs/libzip
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""
S="${WORKDIR}/${P}/src"
