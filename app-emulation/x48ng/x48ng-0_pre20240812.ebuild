# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="HP48 emulator"

HOMEPAGE="https://github.com/gwenhael-le-moine/x48ng"

GIT_COMMIT="249d50c44c7b5344841abbfcc6d16409546e514a"
SRC_URI="https://github.com/gwenhael-le-moine/x48ng/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${GIT_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X sdl"

RDEPEND="sys-libs/ncurses
dev-lang/luajit
sys-libs/readline
X? (
	x11-libs/libX11
	x11-libs/libXext
)
sdl? (
	=media-libs/libsdl-1.2*
	media-libs/sdl-gfx
)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/x48ng-${PVR}-luajit.patch"
	"${FILESDIR}/x48ng-${PVR}-setupscript.patch"
	"${FILESDIR}/x48ng-${PVR}-manpages.patch"
)

src_compile() {
	local conf

	if use X; then
		conf+=" WITH_X11=yes"
	else
		conf+=" WITH_X11=no"
	fi

	if use sdl; then
		conf+=" WITH_SDL=yes"
	else
		conf+=" WITH_SDL=no"
	fi

	emake ${conf}
}

src_install() {
	emake install PREFIX="${D}/usr" MANDIR="${D}/usr/share/man" DOCDIR="${D}/usr/share/doc/${P}"
}

pkg_postinst() {
	elog "Run /usr/share/x48ng/setup-x48ng-home.sh to setup your ~/.config/x48ng/. It sets up a HP 48GX with a 128KB card in port 1 and a 4MB card in port 2"
}
