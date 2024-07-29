# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs savedconfig

DESCRIPTION="Status monitor for window managers that use WM_NAME/stdin to fill the status bar"
HOMEPAGE="https://tools.suckless.org/slstatus/"
SRC_URI="https://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

IUSE="savedconfig"

RDEPEND="
	x11-libs/libX11
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"

src_prepare(){
	default

	sed -i \
		-e "s/ -Os//" \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s| -s$||g}" \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die

	restore_config config.def.h
}

src_compile(){
	emake CC="$(tc-getCC)"
}

src_install(){
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs

	save_config config.def.h
}
