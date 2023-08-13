# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Cross-development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/"
EGIT_REPO_URI="https://github.com/cc65/cc65.git"
EGIT_COMMIT="V${PV}"

LICENSE="ZLIB"
SLOT="0"

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	dodoc README.md
}
