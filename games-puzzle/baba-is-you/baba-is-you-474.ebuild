# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Baba Is You"

inherit desktop

DESCRIPTION="Puzzle game where you can change the rules by which you play"
HOMEPAGE="https://www.hempuli.com/baba/"
SRC_URI="BIY_linux.tar.gz"
S="${WORKDIR}"/"${MY_PN}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist fetch splitdebug"

DIR="/opt/${PN}"
QA_PREBUILT="${DIR#/}/*"

RDEPEND="virtual/opengl"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo " https://hempuli.itch.io/baba"
	einfo "and move it to your distfiles directory."
}

src_install() {
	local arch=$(usex amd64 64 32)
	insinto "${DIR}"
	doins -r Assets.dat gamecontrollerdb.txt Data/

	exeinto "${DIR}"/bin${arch}
	doexe bin${arch}/Chowdren

	exeinto "${DIR}"
	doexe run.sh

	newicon icon.bmp ${PN}.bmp
	make_desktop_entry /usr/bin/${PN} "${MY_PN}" ${PN}.bmp LogicGame
	dosym -r "${DIR}"/run.sh /usr/bin/${PN}
}
