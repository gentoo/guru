# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A list based tiling window manager in the vein of dwm, bspwm, and xmonad."
HOMEPAGE="https://bitbucket.org/natemaia/dk/src/master/"
EGIT_REPO_URI="https://bitbucket.org/natemaia/dk.git"

inherit toolchain-funcs flag-o-matic xdg-utils git-r3 #desktop

LICENSE="MIT"
SLOT="0"
IUSE="examples man"

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

QA_FLAGS_IGNORED="usr/bin/*"

#KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~ppc64 ~riscv ~x86"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

	sed -i \
	-e "s/ -Os / /" \
	-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
	Makefile || die
}

src_compile() {
	# -Os not happy
	replace-flags -Os -O2

	emake CC="$(tc-getCC)"
}

src_install() {
	dodoc README.md
	if use man; then
		#sed "s/VERSION/${VERSION}/g" man/dk.1 || die
	    doman man/*.*
	fi
	#dobin dk dkcmd
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" DOC="/usr/share/doc/${PF}" MAN="/usr/share/man/man1/" install
	#dobin ${D}/dk
#	if use examples ; then
#		insinto /etc/xdg/sxhkd
#		doins doc/sxhkdrc doc/dkrc
#		insinto /etc/xdg/dk
#		doins doc/scripts
#	fi
}

src_test() {
	emake test
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
