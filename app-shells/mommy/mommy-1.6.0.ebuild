# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="mommy's here to support you, in any shell, on any system~"
HOMEPAGE="https://github.com/FWDekker/mommy"

SRC_URI="https://github.com/FWDekker/mommy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_install() {
	dobin "${S}/src/main/sh/mommy"
	dodoc "${S}/src/main/man/man1/mommy.1"
	dofishcomp "${S}/src/main/completions/fish/mommy.fish"
	dozshcomp "${S}/src/main/completions/zsh/_mommy"
}
