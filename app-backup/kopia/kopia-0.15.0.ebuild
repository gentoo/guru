# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Kopia - Fast And Secure Open-Source Backup"
HOMEPAGE="https://github.com/kopia/kopia"
SRC_URI="
	https://github.com/kopia/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://storage.googleapis.com/zhuyifei-static/gentoo/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 MIT BSD BSD-2 CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

src_compile() {
	ego build -v -x -work -o ${PN}
}

src_test() {
	ego test -v $(ego list ./... | grep -v /vendor/)
}

src_install() {
	dobin ${PN}
	einstalldocs
}
