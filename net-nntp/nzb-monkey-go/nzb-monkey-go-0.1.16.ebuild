# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Golang version of the NZB Monkey with included NZB direct search"
HOMEPAGE="https://github.com/Tensai75/nzb-monkey-go"
SRC_URI="
	https://github.com/Tensai75/nzb-monkey-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/SigHunter/${CATEGORY}/-/raw/main/${PN}/${P}-deps.tar.xz
"

LICENSE="MIT"
# vendored licenses
LICENSE+=" Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags="-X main.appVersion=${PV}"
}

src_install() {
	dobin nzb-monkey-go
	einstalldocs
}
