# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="virtual machine designed for extremely compact low-level audiovisual programs"
HOMEPAGE="http://viznut.fi/ibniz/"
SRC_URI="http://viznut.fi/ibniz/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+X"

DEPEND="
	media-libs/libsdl
	X? ( x11-libs/libX11 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -r \
		-e "s/gcc/$(tc-getCC)/" \
		-e "s/^FLAGS=(.*)$/FLAGS=${CFLAGS} \1 ${LDFLAGS}/" \
		-e "s/-s //" \
		-i Makefile || die
}

src_configure() {
	if use !X; then
		sed -i -e 's;-DX11;;' -e 's;-lX11;;' Makefile || die
	fi
}

src_install() {
	dobin ibniz
	dodoc -r examples
}
