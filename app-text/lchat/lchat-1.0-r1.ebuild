# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Line oriented front end for ii-like chat programs"
HOMEPAGE="https://tools.suckless.org/lchat/"
SRC_URI="https://dl.suckless.org/tools/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-libs/libgrapheme"
DEPEND="${RDEPEND}"
IUSE="+examples"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS" LIBS="-lgrapheme $LDFLAGS" all $(usex examples filter/indent)
}

src_install() {
	doman lchat.1
	dobin lchat
	mv filter/indent lchat-indent
	use examples && dobin lchat-indent
}
