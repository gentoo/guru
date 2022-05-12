# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Additional functions for manipulation and analysis of strings"
HOMEPAGE="https://octave.sourceforge.io/strings/index.html"

LICENSE="GPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=sci-mathematics/octave-3.8.0
	dev-libs/libpcre
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-build-against-octave-6.patch"
	"${FILESDIR}/${P}-err-instead-of-gripes.patch"
)
