# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Interactive tree-like terminal file manager"
HOMEPAGE="https://github.com/LeperGnome/bt"
SRC_URI="
	https://github.com/LeperGnome/bt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build ./cmd/bt
}

src_test() {
	ego test ./...
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
