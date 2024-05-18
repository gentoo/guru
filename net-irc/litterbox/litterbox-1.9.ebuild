# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="TLS-only IRC logger"
HOMEPAGE="https://git.causal.agency/litterbox/about/"
SRC_URI="https://git.causal.agency/${PN}/snapshot/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-db/sqlite:3=
	dev-libs/libretls:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	tc-export CC

	# note: not an autoconf configure script
	edo ./configure --prefix="${EPREFIX}"/usr --mandir="${EPREFIX}"/usr/share/man
}

src_compile() {
	emake all
}
