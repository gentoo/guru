# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Computer-Aided Control System Design"
HOMEPAGE="https://octave.sourceforge.io/control/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-4.0.0"
RDEPEND="
	${DEPEND}
	sci-libs/slicot
"

PATCHES=(
	"${FILESDIR}/${PN}-use-external-slicot.patch"
	"${FILESDIR}/${PN}-lapack-3.10.0.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)

src_prepare() {
	default
	#bundled slicot
	rm -f src/slicot.tar.gz || die
	octaveforge_src_prepare
}
