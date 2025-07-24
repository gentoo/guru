# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A lightweight, secure, and feature-rich Discord TUI client. "
HOMEPAGE="https://github.com/ayn2op/discordo"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ayn2op/$PN.git"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/ayn2op/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

	# if discordo ever makes a version in future, and if another person updates it, be sure to change this line to your
	# own depfile link
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
fi

LICENSE="MIT"
SLOT="0"

src_compile() {
	ego build -o "bin/$PN"
}

src_install() {
	dobin "bin/$PN"
}
