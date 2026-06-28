# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Minimal system info fetcher written in C with Lua configuration"
HOMEPAGE="https://codeberg.org/nzuum/fetchit"

EGIT_REPO_URI="https://codeberg.org/nzuum/fetchit.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/lua:5.4"
DEPEND="${RDEPEND}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -I/usr/include/lua5.4 -I src" \
		LIBS="-llua5.4" \
		|| die
}

src_install() {
	dobin build/fetchit
	dodoc README.md

	insinto /usr/share/fetchit
	doins -r config/*
}

pkg_postinst() {
	elog "Default config and logos have been installed to /usr/share/fetchit"
	elog "To set them up for your user, run:"
	elog "    mkdir -p ~/.config/fetchit"
	elog "    cp -r /usr/share/fetchit/* ~/.config/fetchit/"
}