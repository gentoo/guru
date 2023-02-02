# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="ANSI/VT stream parser"
HOMEPAGE="https://github.com/japhb/Terminal-ANSIParser"
SRC_URI="mirror://zef/T/ER/TERMINAL_ANSIPARSER/cebda18e6373a89ae1c8e06a71848161d005734f.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/dist"
