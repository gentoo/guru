# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Wego is a weather client for the terminal"
HOMEPAGE="https://github.com/schachmat/wego"
SRC_URI="https://github.com/schachmat/wego/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

LICENSE="BSD ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

src_compile() {
	ego build -v -x -o wego || die
}

src_install() {
	dobin wego
	dodoc README.md
}
