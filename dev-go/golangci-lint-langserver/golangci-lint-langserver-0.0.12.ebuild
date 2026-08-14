# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="golangci-lint language server"
HOMEPAGE="https://github.com/nametake/golangci-lint-langserver"
SRC_URI="
	https://github.com/nametake/golangci-lint-langserver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-go/golangci-lint"

src_compile() {
	ego build
}

src_test() {
	ego test ./...
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
