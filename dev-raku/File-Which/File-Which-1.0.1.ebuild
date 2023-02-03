# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="1dfbeba2f92f8b2b04e8b26619eb20d599198d25"

DESCRIPTION="Find the full or relative paths to an executable program"
HOMEPAGE="https://github.com/azawawi/perl6-file-which"
SRC_URI="https://github.com/azawawi/perl6-file-which/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md examples"
S="${WORKDIR}/perl6-file-which-${COMMIT}"
