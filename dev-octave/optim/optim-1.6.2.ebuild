# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Non-linear optimization toolkit"
HOMEPAGE="https://octave.sourceforge.io/optim/index.html"

LICENSE="GPL-3+ BSD public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-octave/statistics-1.4.0
	>=dev-octave/struct-1.0.12
	>=sci-mathematics/octave-4.0.0
"
RDEPEND="${DEPEND}"
