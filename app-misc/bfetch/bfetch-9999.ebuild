# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Ultra-fast system fetch tool written in C"
HOMEPAGE="https://github.com/Mjoyufull/bfetch"
EGIT_REPO_URI="https://github.com/Mjoyufull/bfetch.git"

LICENSE="AGPL-3"
SLOT="0"

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin bfetch
	dodoc README.md
}
