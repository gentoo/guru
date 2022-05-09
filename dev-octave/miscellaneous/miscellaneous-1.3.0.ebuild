# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Miscellaneous tools that don't fit somewhere else"
HOMEPAGE="https://octave.sourceforge.io/miscellaneous/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sci-calculators/units
	>=sci-mathematics/octave-3.8.0
	sys-libs/libtermcap-compat
	sys-libs/ncurses-compat
"
RDEPEND="${DEPEND}"
