# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Easy to use unprivileged Linux container packed in a single portable executable"
HOMEPAGE="https://github.com/Kron4ek/Conty"

inherit linux-info

NAME="${PN}_lite_dwarfs.sh"

SRC_URI="https://github.com/Kron4ek/Conty/releases/download/${PV}/${NAME} -> $P"
KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

CONFIG_CHECK="
	IA32_EMULATION
	USER_NS
"

src_install() {
	dobin "${DISTDIR}/${P}"
}

pkg_postinst() {
	einfo "How to use: $ ${NAME} [command] [command_arguments]"
	einfo "For example: ${NAME} steam"
	einfo "or"
	einfo "WINEPREFIX=$HOME/wine-conty ${NAME} gamescope -f -- wine ./game.exe"

}
