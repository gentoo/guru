# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Wego is a weather client for the terminal"
HOMEPAGE="https://github.com/schachmat/wego"
SRC_URI="
	https://github.com/schachmat/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"

LICENSE="BSD ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

src_compile() {
	ego build -v -x . || die
}

src_install() {
	dobin wego
	dodoc README.md
}
