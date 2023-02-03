# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="A bag of small text processing tricks"
HOMEPAGE="https://github.com/japhb/Text-MiscUtils"
SRC_URI="mirror://zef/T/EX/TEXT_MISCUTILS/8c1fc412964235de0ff8180d2056ec5915090df9.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
RDEPEND="dev-raku/Terminal-ANSIColor"
DEPEND="${RDEPEND}"
