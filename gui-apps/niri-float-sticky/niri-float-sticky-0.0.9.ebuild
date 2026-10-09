# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A utility to make floating windows visible across all workspaces in niri"
HOMEPAGE="https://github.com/probeldev/niri-float-sticky"
SRC_URI="
	https://github.com/probeldev/niri-float-sticky/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags "-X main.version=v${PV}" -o ${PN} .
}

src_install() {
	dobin ${PN}
	einstalldocs
}
