# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="Raku / Perl6 Module Management"
HOMEPAGE="https://raku.land/github:ugexe/zef"
SRC_URI="https://github.com/ugexe/zef/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"

src_install() {
	rakudo_src_install
	rakudo_symlink_bin zef
}
