# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A basic clipboard manager for Wayland."
HOMEPAGE="https://github.com/chmouel/clipman/"
SRC_URI="https://github.com/chmouel/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-deps.tar.xz"

LICENSE="BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=gui-apps/wl-clipboard-2
	gui-libs/wlroots
"

src_compile() {
	ego build .
}

src_install() {
	dobin ${PN}

	doman docs/${PN}.1
	local DOCS=("README.md")
	einstalldocs
}
