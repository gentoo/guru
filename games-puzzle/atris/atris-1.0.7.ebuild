# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop

DESCRIPTION="Alizarin tetris"
HOMEPAGE="https://www.wkiri.com/projects/atris/"
SOUNDS_PV="1.0.1"
SRC_URI="
	http://www.gnu-darwin.org/distfiles/${P}.tar.gz
	http://www.gnu-darwin.org/distfiles/${PN}-sounds-${SOUNDS_PV}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc +sound"
DEPEND="
	acct-group/gamestat
	media-libs/freetype
	media-libs/libsdl
	media-libs/sdl-ttf
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-fno-common.patch
	"${FILESDIR}"/${P}-path-and-fullscreen.patch
	"${FILESDIR}"/${P}-no-implicit.patch
)

src_prepare() {
	sed -i 's#games/#share/#' configure.in || die
	default
	eautoreconf
}

src_install() {
	dobin atris
	insinto /usr/share/${PN}
	doins -r styles graphics

	rm "${ED}/usr/share/${PN}/styles"/Makefile* || die
	rm "${ED}/usr/share/${PN}/graphics"/Makefile* || die

	if use sound; then
		pushd "${WORKDIR}"/${PN}-sounds-${SOUNDS_PV} >/dev/null || die
		doins -r sounds
		popd >/dev/null || die
		rm "${ED}/usr/share/${PN}/sounds"/Makefile* || die
	fi

	if use doc; then
		DOCS=( Docs/*html Docs/*jpg )
		einstalldocs
	fi
	dodoc AUTHORS NEWS README

	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} Atris ${PN} BlocksGame

	newenvd - 99${PN} <<-_EOF_
		CONFIG_PROTECT=/var/games/${PN}/
	_EOF_

	keepdir /var/games/${PN}
	insinto /var/games/${PN}
	doins Atris.*

	fowners :gamestat /var/games/${PN}/Atris.{Players,Scores}
	fperms 664 /var/games/${PN}/Atris.{Players,Scores}
}
