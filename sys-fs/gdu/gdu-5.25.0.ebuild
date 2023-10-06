# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Disk usage analyzer with console interface written in Go"
HOMEPAGE="https://github.com/dundee/gdu"
SRC_URI="https://github.com/dundee/gdu/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags "-s -w -X 'github.com/dundee/gdu/build.Version=${PV}'" -v -x -work -o "${PN}" "./cmd/${PN}"
}

src_install() {
	einstalldocs
	dodoc -r README.md gdu.1.md
	dobin gdu
	doman gdu.1
}

src_test() {
	ego test ./...
}
