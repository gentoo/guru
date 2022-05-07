# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Additional statistics functions for Octave"
HOMEPAGE="https://octave.sourceforge.io/statistics/index.html"

LICENSE="GPL-3+ public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-octave/io-1.0.18
	>=sci-mathematics/octave-4.0.0
"
RDEPEND="${DEPEND}"
