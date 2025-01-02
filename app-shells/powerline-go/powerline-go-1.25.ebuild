# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A powerline like prompt for Bash, Zsh, Fish written in Go lang."
HOMEPAGE="https://github.com/justjanne/powerline-go"
SRC_URI="https://github.com/justjanne/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/Tapchicoma/ebuild-deps/raw/refs/heads/main/go-deps/${PN}-${PV}-deps.tar.xz"

LICENSE="GPL-3 MIT Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DOCS=(README.md)

src_compile() {
	go build -o release/powerline-go . || die
}

src_install() {
	dobin release/powerline-go
	einstalldocs
}

pkg_postinst() {
	elog 'Check installed documentation to how-to add this to the shell prompt'
}
