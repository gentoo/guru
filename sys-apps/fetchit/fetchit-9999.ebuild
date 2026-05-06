# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Minimal system info fetcher written in C with Lua configuration"
HOMEPAGE="https://codeberg.org/nzuum/fetchit"
EGIT_REPO_URI="https://codeberg.org/nzuum/fetchit.git"

inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/lua:5.4"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
    emake || die
}

src_install() {
    # Makefile now respects DESTDIR + PREFIX (recent commit)
    emake DESTDIR="${D}" PREFIX="/usr" install || die

    dodoc README.md

    # Install default config and logos
    insinto /usr/share/fetchit
    doins -r config/*
}

pkg_postinst() {
    elog "Default config and logos have been installed to /usr/share/fetchit"
    elog "To set them up for your user, run:"
    elog "    make install-config"
    elog "or copy manually:"
    elog "    mkdir -p ~/.config/fetchit"
    elog "    cp -r /usr/share/fetchit/* ~/.config/fetchit/"
} 