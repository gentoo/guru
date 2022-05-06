# Copyright 1999-202 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Additional linear algebra code"
HOMEPAGE="https://octave.sourceforge.io/linear-algebra/index.html"

LICENSE="GPL-3+ LGPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-4.0.0"
RDEPEND="${DEPEND}"
