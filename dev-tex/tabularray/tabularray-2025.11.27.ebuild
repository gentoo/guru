# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

DESCRIPTION="Typeset tabulars and arrays with LATEX3"
HOMEPAGE="https://www.ctan.org/pkg/tabularray/"
SRC_URI="https://github.com/lvjr/tabularray/archive/refs/tags/2025C.tar.gz -> ${P}.tar.gz
	doc? ( https://github.com/lvjr/tabularray/releases/download/2025C/tabularray-2025C.zip -> ${P}-doc.zip )"

S="${WORKDIR}/${PN}-2025C"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-macos"
IUSE="doc"

RDEPEND="
	dev-tex/ninecolors
	dev-texlive/texlive-latexrecommended
	>=dev-texlive/texlive-latexextra-2012
	dev-texlive/texlive-plaingeneric
"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"

TEXMF="/usr/share/texmf-site"

src_install() {
	latex-package_src_doinstall styles
	dodoc README.md
	if use doc ; then
		# Upstream ships the manual only as a prebuilt PDF in the release
		# archive, so install that rather than rebuilding with lualatex.
		cp "${WORKDIR}"/${PN}/tabularray.pdf "${S}"/ || die
		latex-package_src_doinstall pdf
	fi
}
