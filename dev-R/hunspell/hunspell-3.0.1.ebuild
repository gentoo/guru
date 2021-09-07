# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages toolchain-funcs

DESCRIPTION='High-Performance Stemmer, Tokenizer and Spell Checker'
KEYWORDS="~amd64"
LICENSE="GPL-2 LGPL-2.1 MPL-1.1"

DEPEND="
	>=dev-lang/R-3.0.2
	dev-R/Rcpp
	dev-R/digest
"
RDEPEND="
	${DEPEND}
	>=dev-R/Rcpp-0.12.12
"

#bundling status: https://github.com/ropensci/hunspell/issues/34
src_prepare() {
	tc-export AR
	R-packages_src_prepare
}
