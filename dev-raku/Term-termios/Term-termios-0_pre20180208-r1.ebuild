# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="f4c84e1d95cb11be7655c489d2e470011ff269c8"

DESCRIPTION="termios routines for Raku"
HOMEPAGE="https://github.com/krunen/term-termios"
SRC_URI="https://github.com/krunen/term-termios/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
BDEPEND="dev-raku/LibraryMake"
S="${WORKDIR}/term-termios-${COMMIT}"

src_compile() {
	cmd="require 'Build.pm'; ::('Build').new.build('${S}');"
	raku -I. -e "$cmd" || die "Failed to build ${P}."
}
