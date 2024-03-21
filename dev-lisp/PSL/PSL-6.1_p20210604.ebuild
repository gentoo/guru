# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="f489ea67801d04d44cc65d63365d187cdd58dbe9"

DESCRIPTION="Portable Standard Lisp"
HOMEPAGE="https://github.com/blakemcbride/PSL"
SRC_URI="https://github.com/blakemcbride/PSL/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

IUSE="doc"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	doc? (
		app-text/texlive-core
		dev-texlive/texlive-latex
	)
"

DOCS=( README.md README.2 manual/sl.pdf manual/lispman.pdf )
PATCHES="${FILESDIR}/${P}-respect-flags.patch"

src_compile() {
	tc-export CC
	default
	emake sizes
	if use doc; then
		pushd manual || die
		emake all
		popd || die
	fi
}

src_install() {
	newbin lisp standardlisp
	exeinto "/usr/libexec/${PN}"
	doexe sizes
	einstalldocs
}
