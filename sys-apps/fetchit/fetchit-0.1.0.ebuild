# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Minimal system info fetcher written in C with Lua configuration"
HOMEPAGE="https://codeberg.org/nzuum/fetchit"

# Using a recent commit (update this when you want a newer version)
COMMIT="b0ed7c1fe08d32fc26e458cd971930d550720462"
SRC_URI="https://codeberg.org/nzuum/fetchit/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/lua:5.4"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/fetchit-${COMMIT}"

src_compile() {
    emake || die
}

src_install() {
    emake DESTDIR="${D}" PREFIX="/usr" install || die

    dodoc README.md

    # Install default config and logos
    insinto /usr/share/fetchit
    doins -r config/*
}

pkg_postinst() {
    elog "Default config installed to /usr/share/fetchit"
    elog "Run the following to set it up for your user:"
    elog "    mkdir -p ~/.config/fetchit"
    elog "    cp -r /usr/share/fetchit/* ~/.config/fetchit/"
}