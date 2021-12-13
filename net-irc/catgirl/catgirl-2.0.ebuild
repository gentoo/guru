# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 toolchain-funcs

DESCRIPTION="TLS-only terminal IRC client"
HOMEPAGE="https://git.causal.agency/catgirl/about/"
SRC_URI="https://git.causal.agency/${PN}/snapshot/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/libretls:=
	sys-libs/ncurses:=
"
BDEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}"

DOCS=( README.7 scripts/chat.tmux.conf )

src_configure() {
	./configure \
		--prefix="${EPREFIX}"/usr \
		--mandir="${EPREFIX}"/usr/share/man || die
	tc-export CC
}

src_compile() {
	emake all
}

src_install() {
	default
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
