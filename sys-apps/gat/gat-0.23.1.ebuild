# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Cat alternative written in Go"
HOMEPAGE="https://github.com/koki-develop/gat"

SRC_URI="https://github.com/koki-develop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/kuprTheMan/contribute-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build .
}

src_install() {
	dobin ${PN}
	dodoc README.md CHANGELOG.md
}
