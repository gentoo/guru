# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Modern implementation of the ancient unix compress(1) tool"
HOMEPAGE="https://codeberg.org/NRK/nix-compress"

SRC_URI="https://codeberg.org/NRK/nix-compress/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"
LICENSE="GPL-3+ MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!app-arch/ncompress"

src_compile() {
	edo $(tc-getCC) ${CFLAGS} -o compress nix-compress.c ${LDFLAGS}
}

src_install() {
	dobin compress
	dosym compress /usr/bin/uncompress
	doman man/compress.1 man/uncompress.1
	dodoc README.md
}
