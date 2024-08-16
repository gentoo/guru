# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

inherit lua-single prefix toolchain-funcs

DESCRIPTION="HP48 emulator"

HOMEPAGE="https://github.com/gwenhael-le-moine/x48ng"

SRC_URI="https://github.com/gwenhael-le-moine/x48ng/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sdl X"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}
sys-libs/ncurses:=
sys-libs/readline:=
X? (
	x11-libs/libX11
	x11-libs/libXext
)
sdl? (
	=media-libs/libsdl-1.2*
	media-libs/sdl-gfx:=
)
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -e "s/lua)/${ELUA})/" -e 's/LICENSE//' -i Makefile || die
	default
}

src_configure() {
	conf=(
		$(usex X WITH_X11={yes,no})
		$(usex sdl WITH_SDL={yes,no})
	)
}

src_compile() {
	tc-export CC PKG_CONFIG
	export {C,CPP,LD}FLAGS
	emake ${conf[@]}
}

src_install() {
	emake install DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
		MANDIR="${EPREFIX}/usr/share/man" \
		DOCDIR="${EPREFIX}/usr/share/doc/${PF}" \
		${conf[@]}
	hprefixify "${ED}"/usr/share/x48ng/setup-x48ng-home.sh
}

pkg_postinst() {
	elog "Run ${EROOT}/usr/share/x48ng/setup-x48ng-home.sh to setup your"
	elog "config directory."
	elog
	elog "The X48 emulator requires an HP48 ROM image to run."
	elog
	elog "If you own an HP-48 calculator, you can use the ROMDump utility"
	elog "included with this package to obtain it from your calculator."
	elog "The instructions of how to do this are included in the package."
	elog
	elog "Alternatively, HP has provided the ROM images for non-commercial"
	elog "use only."
	elog
	elog "Due to confusion over the legal status of these ROMs you must"
	elog "manually download one from http://www.hpcalc.org/hp48/pc/emulators/"
	elog "If you consent to it, this can be done with the aforementioned"
	elog "script. In that case, it sets up a HP 48GX with a 128KB card in"
	elog "port 1 and a 4MB card in port 2."
	elog
	elog "You will only have to do this the first time you run x48ng. The"
	elog "ROM will be stored in your config directory for future runs."
}
