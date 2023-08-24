# Copyright 2022, 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Cross-development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/"
SRC_URI="https://github.com/cc65/cc65/archive/refs/tags/V${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	dodoc README.md
}
