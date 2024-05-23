# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop

DESCRIPTION="BlockOut II is an adaptation of the original Blockout DOS game"
HOMEPAGE="https://www.blockout.net/blockout2/"
SRC_URI="
	https://downloads.sourceforge.net/blockout/bl25-src.tar.gz
	https://downloads.sourceforge.net/blockout/bl25-linux-x86.tar.gz"

S="${WORKDIR}"/BL_SRC

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	media-libs/alsa-lib
	media-libs/libsdl
	media-libs/sdl-mixer
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}"/${P}-datadir.patch

src_compile() {
	GAME_DATADIR="/usr/share/${PN}"
	emake -C ImageLib/src
	emake -C BlockOut GAME_DATA_PREFIX="${GAME_DATADIR}"
}

src_install() {
	dobin BlockOut/blockout

	insinto "${GAME_DATADIR}"/images
	doins -r "${WORKDIR}"/blockout/images/*

	insinto "${GAME_DATADIR}"/sounds
	doins -r "${WORKDIR}"/blockout/sounds/*

	dodoc "${WORKDIR}"/blockout/README.txt

	newicon "${FILESDIR}/blockout_icon.png" blockout_icon.png
	make_desktop_entry ${PN} BlockOut blockout_icon Game
}
