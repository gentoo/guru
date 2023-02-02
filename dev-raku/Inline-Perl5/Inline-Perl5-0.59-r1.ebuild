# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="Use Perl 5 code in a Raku program"
HOMEPAGE="https://raku.land/cpan:NINE/Inline::Perl5"
SRC_URI="mirror://cpan/authors/id//N/NI/NINE/Perl6/${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="primaryuri"
DOCS="README.md examples"
BDEPEND=">=dev-lang/perl-5.20.0
	dev-raku/Distribution-Builder-MakeFromJSON
	test? ( dev-raku/File-Temp )"
RDEPEND=">=dev-lang/perl-5.20.0"
