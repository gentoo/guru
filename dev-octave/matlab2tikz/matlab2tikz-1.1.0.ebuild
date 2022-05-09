# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="convert native MATLAB(R) figures to TikZ/Pgfplots"
HOMEPAGE="https://github.com/matlab2tikz/matlab2tikz"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-4.0.0"
RDEPEND="${DEPEND}"

src_install() {
	dodoc README.md CHANGELOG.md
	export pkgpath="/usr/share/octave/site/m/${PN}"
	insinto "${pkgpath}"
	doins -r src/*
}

pkg_postinst() {
	# TODO: is there a way to do this automatically for all users?
	einfo "Run addpath('${pkgpath}'); inside octave to add this package to the octave path"
	optfeature "to build the generated files" dev-texlive/texlive-pictures dev-texlive/texlive-latexextra
}
