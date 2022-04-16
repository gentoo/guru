# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-1 luajit )

inherit lua-single

DESCRIPTION="Spreadsheet Calculator Improvised -- An ncurses spreadsheet program for terminal"
HOMEPAGE="https://github.com/andmarti1424/sc-im"
SRC_URI="https://github.com/andmarti1424/sc-im/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X plots wayland xls xlsx lua ods tmux"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"

PATCHES=(
	"${FILESDIR}/${P}-prefix.patch"
	"${FILESDIR}/${P}-automagic.patch"
	"${FILESDIR}/${P}-clipboard.patch"
)

DEPEND="
	sys-libs/ncurses

	lua? (
		${LUA_DEPS}
	)
	ods? (
		dev-haskell/libxml
		dev-libs/libzip
	)
	plots? ( sci-visualization/gnuplot )
	tmux? ( app-misc/tmux )
	wayland? ( gui-apps/wl-clipboard )
	X? ( x11-misc/xclip )
	xls? (
		dev-libs/libxls
	)
	xlsx? (
		dev-libs/libxlsxwriter
		dev-haskell/libxml
		dev-libs/libzip
	)
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"
S="${WORKDIR}/${P}/src"

pkg_setup() {
	export X=$(usex X)
	export TMUX=$(usex tmux)
	export WAYLAND=$(usex wayland)
	export PLOTS=$(usex plots)
	export XLS=$(usex xls)
	export XLSX=$(usex xlsx)
	export LUA=$(usex lua)
	( use xlsx || use ods ) && export XML_ZIP="yes"

	# Prefer wayland support over X, and tmux support over both wayland and X.
	use wayland && export X="no"
	use tmux && export X="no" && export WAYLAND="no"

	# Notifying the user about which clipboard support is enabled if conflicting flags are set
	CONFLICTING=$(usex tmux "tmux " "")$(usex wayland "wayland " "")$(usex X "X" "")
	if ( use tmux && ( use wayland || use X ) ) ; then
		elog "Conflicting flags for clipboard support are set: ${CONFLICTING}"
		elog "tmux support has been preferred."
	elif ( use wayland && use X ) ; then
		elog "Conflicting flags for clipboard support are set: ${CONFLICTING}"
		elog "Wayland support has been preferred."
	fi

	# Run lua setup
	lua-single_pkg_setup
}
