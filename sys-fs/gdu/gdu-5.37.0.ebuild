# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast disk usage analyzer with console interface written in Go"
HOMEPAGE="https://github.com/dundee/gdu"
SRC_URI="
	https://github.com/dundee/gdu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/yamader/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

DOCS=( README.md gdu.1.md )

src_compile() {
	ego build -ldflags "-X 'github.com/dundee/gdu/v5/build.Version=${PV}'" ./cmd/gdu
}

src_install() {
	dobin gdu
	doman gdu.1
	einstalldocs
}

src_test() {
	ego test ./...
}
