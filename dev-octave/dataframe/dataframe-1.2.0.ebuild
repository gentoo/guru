# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Data manipulation toolbox similar to R data.frame"
HOMEPAGE="https://octave.sourceforge.io/dataframe/index.html"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-3.2.0"
RDEPEND="${DEPEND}"
