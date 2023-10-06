# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="distributed, offline-first bug tracker"
HOMEPAGE="https://github.com/MichaelMure/git-bug"

SRC_URI="https://github.com/MichaelMure/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

RESTRICT="strip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

src_compile() {
	ego generate
	ego build \
		-ldflags "-s -w -X github.com/MichealMure/git-bug/commands.GitLastTag=${PV} -X github.com/MichealMure/git-bug/commands.GitExactTag=${PV}" \
		-o ${PN}
}

src_install() {
	dobin ${PN}
}

src_test() {
	CI=true ego test
}
