# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Process manager for Procfile-based applications and tmux"
HOMEPAGE="https://github.com/DarthSim/overmind"
SRC_URI="
	https://github.com/DarthSim/overmind/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/overmind/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="MIT BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-misc/tmux
"

src_compile() {
	go build -ldflags "-s -w" || die "go build failed"
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}
