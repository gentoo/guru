# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="A byte-sized window manager written in C"
HOMEPAGE="https://berrywm.org"
SRC_URI="https://github.com/JLErvin/berry/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="examples"

DEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-libs/libXinerama
	x11-libs/libX11
	x11-libs/libXft
"
RDEPEND="${DEPEND}
	x11-misc/sxhkd
"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" DOCPREFIX="${EPREFIX}/usr/share/doc/${PF}" install

	insinto /etc/xdg/sxhkd
	doins examples/sxhkdrc

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}
	fi

}
