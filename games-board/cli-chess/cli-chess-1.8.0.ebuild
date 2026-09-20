# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1
RESTRICT="test" #this breaks sandbox

DESCRIPTION="A highly customizable way to play chess in your terminal"
HOMEPAGE="https://github.com/trevorbayless/cli-chess"
SRC_URI="https://github.com/trevorbayless/cli-chess/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	games-board/fairy-stockfish
	games-board/berserk
	dev-python/chess[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
"
src_prepare() {
	distutils-r1_src_prepare
	rm -f src/cli_chess/modules/engine/binaries/fairy-stockfish_* || die
}

python_install() {
	distutils-r1_python_install

	local sitedir
	sitedir="$(python_get_sitedir)"
	dosym "${EPREFIX}/usr/bin/fairy-stockfish" \
		"${sitedir#"${D}"}/cli_chess/modules/engine/binaries/fairy-stockfish_x86-64_linux"
}
