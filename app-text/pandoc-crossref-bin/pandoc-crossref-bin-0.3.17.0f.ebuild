# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="Pandoc filter for cross-references"
HOMEPAGE="https://github.com/lierdakil/pandoc-crossref"
SRC_URI="https://github.com/lierdakil/pandoc-crossref/releases/download/v${PV}/pandoc-crossref-Linux.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
|| ( ~app-text/pandoc-bin-3.1.12.3 >=app-text/pandoc-3 )
"

src_install() {
	exeinto /usr/bin
	newexe pandoc-crossref pandoc-crossref
	newman pandoc-crossref.1 pandoc-crossref.1
}
