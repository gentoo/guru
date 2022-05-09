# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

COMMIT="98fa88db1ba85e108655f25b3ca96a821862eb85"

DESCRIPTION="Additional functions for manipulation and analysis of strings"
HOMEPAGE="https://octave.sourceforge.io/strings/index.html"
SRC_URI="mirror://sourceforge/code-snapshots/hg/o/oc/octave/${PN}/octave-${PN}-${COMMIT}.zip"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=sci-mathematics/octave-3.8.0
	dev-libs/libpcre
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_unpack() {
	octaveforge_src_unpack
	pushd "${WORKDIR}" || die
	mv "octave-${PN}-${COMMIT}" "${PN}" || die
}
