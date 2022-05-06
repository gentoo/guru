# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="A mostly MATLAB-compatible fuzzy logic toolkit for Octave"
HOMEPAGE="https://octave.sourceforge.io/fuzzy-logic-toolkit/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-3.2.4"
RDEPEND="${DEPEND}"
