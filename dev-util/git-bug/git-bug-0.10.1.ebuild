# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="distributed, offline-first bug tracker"
HOMEPAGE="https://github.com/git-bug/git-bug"
SRC_URI="https://github.com/git-bug/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://joecool.ftfuchs.com/godeps/${P}-deps.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RESTRICT="strip"

src_compile() {
	ego generate
	ego build \
		-ldflags "-s -w -X github.com/git-bug/git-bug/commands.GitLastTag=${PV} -X github.com/git-bug/git-bug/commands.GitExactTag=${PV}" \
		-o ${PN}
}

src_install() {
	dobin ${PN}
}

src_test() {
	CI=true ego test
}
