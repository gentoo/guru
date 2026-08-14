# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A basic clipboard manager for Wayland."
HOMEPAGE="https://github.com/chmouel/clipman/"
SRC_URI="https://github.com/chmouel/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/gentoo-golang-dist/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz"

LICENSE="BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=gui-apps/wl-clipboard-2
"
BDEPEND="
	>=dev-lang/go-1.21
"

src_compile() {
	# CGO is not needed and it would inject -fno-stack-protector
	CGO_ENABLED=0 ego build .
}

src_install() {
	dobin ${PN}

	doman docs/${PN}.1
	local DOCS=("README.md")
	einstalldocs
}
