# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Fast featureful friendly wifi terminal UI"
HOMEPAGE="https://github.com/shazow/wifitui"
SRC_URI="
https://github.com/shazow/wifitui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/2elli/gentoo-tardist/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.24.5"
RDEPEND="|| ( net-misc/networkmanager net-wireless/iwd )"

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	dobin ${PN}

	einstalldocs
}
