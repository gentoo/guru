# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker wrapper xdg

MY_PV="$(ver_rs 1- _)"
MY_P="${PN}_${MY_PV}"

DESCRIPTION="A cyberpunk point-and-click adventure game"
HOMEPAGE="https://www.wadjeteyegames.com/games/primordia/"
SRC_URI="${MY_P}.sh"
S="${WORKDIR}/data/noarch/game"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist fetch"

RDEPEND=">=games-engines/scummvm-2.8.0[mp3,truetype,opengl,vorbis,theora]"
BDEPEND="app-arch/unzip"

DIR="/usr/share/games/scummvm/games/primordia"

src_unpack() {
	unpack_zip "${A}"
}

src_install() {
	insinto "${DIR}"
	doins acsetup.cfg ENGV.tmp Primordia.ags *.tra *.vox "${WORKDIR}/data/noarch/support/icon.png"

	make_wrapper ${PN} "scummvm primordia"
	make_desktop_entry ${PN} "Primordia" "${EPREFIX}/${DIR}/icon.png"
}
