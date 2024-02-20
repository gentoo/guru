# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Baba Is You"

inherit desktop

DESCRIPTION="Puzzle game where you can change the rules by which you play"
HOMEPAGE="https://www.hempuli.com/baba/"
SRC_URI="BIY_linux.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist fetch"

S="${WORKDIR}/${MY_PN}"

# Has bundled media-video/libsdl2 with at least
# [alsa,joystick,pulseaudio,sound]
# Needs alsa-lib to launch with dummy audio even if system has no audio
RDEPEND="
	media-libs/alsa-lib
	media-libs/libglvnd
	virtual/opengl
"

QA_PREBUILT="opt/*"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo " https://hempuli.itch.io/baba"
	einfo "and move it to your distfiles directory."
}

src_install() {
	local arch=$(usex amd64 64 32)
	insinto /opt/${PN}
	doins -r Assets.dat gamecontrollerdb.txt Data/

	exeinto /opt/${PN}/bin${arch}
	doexe bin${arch}/Chowdren

	exeinto /opt/${PN}
	doexe run.sh

	newicon icon.bmp ${PN}.bmp
	dosym -r /usr/share/pixmaps/${PN}.bmp /opt/${PN}/icon.bmp
	make_desktop_entry /usr/bin/${PN} "${MY_PN}" ${PN}.bmp LogicGame
	dosym -r /opt/${PN}/run.sh /usr/bin/${PN}
}
