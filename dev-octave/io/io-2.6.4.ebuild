# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Input/Output in external formats"
HOMEPAGE="https://octave.sourceforge.io/io/index.html"

LICENSE="GPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-4.2.0"
RDEPEND="${DEPEND}"
