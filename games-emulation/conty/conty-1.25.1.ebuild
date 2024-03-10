# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Easy to use unprivileged Linux container packed in a single portable executable"
HOMEPAGE="https://github.com/Kron4ek/Conty"

inherit linux-info

SRC_URI="https://github.com/Kron4ek/Conty/releases/download/${PV}/${PN}_lite_dwarfs.sh"
KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

CONFIG_CHECK="IA32_EMULATION"

src_install() {
	dobin "${DISTDIR}/${PN}_lite_dwarfs.sh"
}

pkg_postinst() {
	einfo "How to use: $ ./conty.sh [command] [command_arguments]"
	einfo "For example: ./conty.sh steam"
	einfo "or"
	einfo "WINEPREFIX=$HOME/wine-conty ./conty.sh gamescope -f -- wine ./game.exe"

}
