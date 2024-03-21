# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Banish the mouse cursor when typing, show it again when the mouse moves"
HOMEPAGE="https://github.com/jcs/xbanish"

SRC_URI="https://github.com/jcs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="ISC"
SLOT="0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXext
"
DEPEND="
	${RDEPEND}
	x11-libs/libXt
"

src_configure() {
	# Makefile doesn't respect user's LDFLAGS
	sed -i \
		-e 's|\$(LIBS) |\$(LIBS) $(LDFLAGS) |g' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin xbanish
	doman xbanish.1
}
