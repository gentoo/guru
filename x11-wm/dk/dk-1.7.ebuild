# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs xdg-utils desktop

DESCRIPTION="A list based tiling window manager in the vein of dwm, bspwm, and xmonad."
HOMEPAGE="https://bitbucket.org/natemaia/dk/src/master/"
SRC_URI="https://bitbucket.org/natemaia/dk/get/bc9bd6349321c27ddb2dd7a9cb7630e2f1794c85.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86"

IUSE="examples man"
RESTRICT=strip

DEPEND="
	x11-base/xcb-proto
	x11-libs/libxcb
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
"

RDEPEND="
	${DEPEND}
	x11-misc/sxhkd
"
#src_prepare() {
#	default

#	-e "s/ -Os / /" \

#	sed -i \
#	-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
#	Makefile || die
#}

src_compile() {
	# -Os not happy
	#replace-flags -Os -O2
	cd natemaia-dk-bc9bd6349321 || die
	emake CC="$(tc-getCC)"
}

src_install() {
	cd natemaia-dk-bc9bd6349321 || die
	if use man; then
		sed "s/VERSION/${VERSION}/g" man/dk.1 || die
	    doman man/*.*
	fi

	dobin dk dkcmd
	make_desktop_entry dk.desktop /usr/share/xsessions/
	#emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	#DOC="/usr/share/doc/${PF}" MAN="/usr/share/man/man1/" install
	#dobin ${D}/dk

#	insinto /etc/xdg/sxhkd
#	doins examples/sxhkdrc

#	if use doc ; then
#		insinto /etc/xdg/sxhkd
#		doins doc/sxhkdrc doc/dkrc
#		insinto /etc/xdg/dk
#		doins doc/scripts
#	fi
}

#src_test() {
#	emake test
#}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
