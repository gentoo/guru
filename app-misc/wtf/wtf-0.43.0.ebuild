# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="The personal information dashboard for your terminal"
HOMEPAGE="https://github.com/wtfutil/wtf"

SRC_URI="https://github.com/wtfutil/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/kuprTheMan/contribute-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="test"

src_compile() {
	ego build -ldflags="-s -w" -o bin/wtfutil
}

src_install() {
	dobin bin/wtfutil
	dodoc README.md
}
