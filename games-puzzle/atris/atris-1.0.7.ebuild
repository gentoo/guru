# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools desktop

DESCRIPTION="Alizarin tetris"
HOMEPAGE="https://www.wkiri.com/projects/atris/"
SRC_URI="http://www.gnu-darwin.org/distfiles/${P}.tar.gz
	http://www.gnu-darwin.org/distfiles/${PN}-sounds-1.0.1.tar.gz"

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
	default
	eautoreconf
}

src_install() {
	dobin atris
	insinto /usr/share/${PN}
	doins -r styles graphics

	if use sound; then
		cd "${WORKDIR}"/${PN}-sounds-1.0.1
		doins -r sounds
		cd "${S}"
	fi

	if use doc; then
		dodoc -a html,jpg Docs
	fi
	dodoc AUTHORS NEWS README

	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} Atris ${PN} BlocksGame

	echo "CONFIG_PROTECT=/var/games/${PN}/" > 99${PN}
	doenvd 99${PN}

	keepdir /var/games/${PN}
	insinto /var/games/${PN}
	doins Atris.*

	fowners :gamestat /var/games/${PN}/Atris.{Players,Scores}
	fperms 664 /var/games/${PN}/Atris.{Players,Scores}
}
