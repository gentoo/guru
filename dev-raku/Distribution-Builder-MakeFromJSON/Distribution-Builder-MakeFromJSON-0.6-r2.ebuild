# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="Makefile based distribution builder"
HOMEPAGE="https://raku.land/cpan:NINE/Distribution::Builder::MakeFromJSON"
SRC_URI="mirror://cpan/authors/id//N/NI/NINE/Perl6/${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
RDEPEND="dev-raku/System-Query"
DEPEND="${RDEPEND}"
DOCS="README.md Changes"
