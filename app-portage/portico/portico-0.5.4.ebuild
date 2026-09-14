# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="An interactive TUI helper for Portage workflows"
HOMEPAGE="https://github.com/catielanier/portico"
SRC_URI="
	https://github.com/catielanier/portico/releases/download/v${PV}/${P}.tar.gz
	https://github.com/catielanier/portico/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="GPL-3+ MIT BSD Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

RDEPEND="
	app-eselect/eselect-repository
	app-portage/gentoolkit
"

src_compile() {
	ego build \
		-ldflags "-X github.com/catielanier/portico/internal/cli.version=${PV}" \
		-o portico \
		./cmd/portico
}

src_test() {
	ego test ./...
}

src_install() {
	dobin portico
	dodoc README.md CHANGELOG.md
}
