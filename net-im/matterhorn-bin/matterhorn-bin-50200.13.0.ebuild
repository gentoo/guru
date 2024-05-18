# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"
MY_P="${MY_PN}-${PV}-fedora-29-x86_64"

DESCRIPTION="Terminal based Mattermost client"
HOMEPAGE="https://github.com/matterhorn-chat/matterhorn"
SRC_URI="https://github.com/matterhorn-chat/${MY_PN}/releases/download/${PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	${DEPEND}
	dev-libs/gmp:0
	sys-libs/ncurses:0/6
	sys-libs/zlib:0/1
"

QA_PREBUILT="*"

src_install() {
	default

	dobin matterhorn

	dodoc docs/commands.md
	dodoc docs/keybindings.md

	insinto /usr/share/${MY_PN}
	exeinto /usr/share/${MY_PN}/notification-scripts
	doins -r emoji
	doins -r syntax
	doexe notification-scripts/notify
}
