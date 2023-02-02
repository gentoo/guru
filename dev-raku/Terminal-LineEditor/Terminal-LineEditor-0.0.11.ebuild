# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="Generalized terminal line editing"
HOMEPAGE="https://github.com/japhb/Terminal-LineEditor"
SRC_URI="mirror://zef/T/ER/TERMINAL_LINEEDITOR/5b16a3e3577ba7f3a0f0234821dd461aa4028f1e.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
RDEPEND="dev-raku/Term-termios
	dev-raku/Terminal-ANSIParser
	dev-raku/Text-MiscUtils"
DEPEND="${RDEPEND}"
