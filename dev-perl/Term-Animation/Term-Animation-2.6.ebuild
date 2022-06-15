# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=KBAUCOM
DIST_EXAMPLES=( examples/color_nature.pl )
inherit perl-module

DESCRIPTION="Animated ASCII Art support for Perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Curses"
DEPEND="${RDEPEND}"
