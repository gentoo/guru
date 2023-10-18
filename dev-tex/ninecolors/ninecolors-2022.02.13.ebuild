# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

DESCRIPTION="Select colors with proper WCAG color contrast"
HOMEPAGE="https://www.ctan.org/pkg/ninecolors/"
SRC_URI="https://mirrors.ctan.org/macros/latex/contrib/ninecolors.zip -> ${P}.zip"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="doc"

RDEPEND="
	dev-texlive/texlive-latexrecommended
	>=dev-texlive/texlive-latexextra-2012
	dev-texlive/texlive-plaingeneric
"
DEPEND="${RDEPEND}"
BDEPEND="
	${RDEPEND}
	app-arch/unzip
"

TEXMF="/usr/share/texmf-site"
S=${WORKDIR}/${PN}

src_install() {
	latex-package_src_doinstall styles
	dodoc README.txt
	if use doc ; then
		latex-package_src_doinstall pdf
	fi
}
