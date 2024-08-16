# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic prefix toolchain-funcs

DESCRIPTION="HP48 emulator"

HOMEPAGE="https://github.com/gwenhael-le-moine/x48ng"

GIT_COMMIT="249d50c44c7b5344841abbfcc6d16409546e514a"
SRC_URI="https://github.com/gwenhael-le-moine/x48ng/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${GIT_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sdl X"

RDEPEND="sys-libs/ncurses:=
dev-lang/luajit:2=
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
	# Use luajit to avoid lua version specific pkg-config
	sed -e 's/$(LIBS)/$(LDFLAGS) &/' \
		-e "s/pkg-config/$(tc-getPKG_CONFIG)/" \
		-e 's/lua)/luajit)/' \
		-e '/gzip/d' \
		-e 's/LICENSE//' \
		-i Makefile || die
	default
}

src_configure() {
	# https://github.com/gwenhael-le-moine/x48ng/issues/24
	use X && filter-lto
	conf=(
		$(usex X WITH_X11={yes,no})
		$(usex sdl WITH_SDL={yes,no})
	)
}

src_compile() {
	tc-export CC
	export {C,LD}FLAGS
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
	elog "Run ${EROOT}/usr/share/x48ng/setup-x48ng-home.sh to setup your config directory. It sets up a HP 48GX with a 128KB card in port 1 and a 4MB card in port 2"
}
