# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Move mouse pointer with keyboard"
HOMEPAGE="https://github.com/sfarajli/vimouse"
SRC_URI="https://github.com/sfarajli/vimouse/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64"

DEPEND="
	x11-libs/libXtst
	x11-libs/libX11
"
src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	dodoc README.md
}
