# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="$(ver_cut 1-3)"
MYP="${PN}-${MYPV}"

inherit octaveforge

DESCRIPTION="Additional functions for manipulation and analysis of strings"
HOMEPAGE="https://octave.sourceforge.io/strings/index.html"
SRC_URI="mirror://sourceforge/octave/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="GPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=sci-mathematics/octave-3.8.0
	dev-libs/libpcre
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${MYP}-156.patch"
	"${FILESDIR}/${MYP}-157.patch"
	"${FILESDIR}/${MYP}-158.patch"
	"${FILESDIR}/${MYP}-160.patch"
)

src_unpack() {
	default
}
