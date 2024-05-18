# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Print an emoji according to traditional chinese calendar and more"
HOMEPAGE="https://github.com/stkw0/zcock"
SRC_URI="https://github.com/stkw0/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/IP2LOCATION-LITE-DB5.BIN.lzma"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/xz-utils"

src_compile() {
	ego build
}

src_install() {
	dobin zcock

	insinto /usr/share
	doins "${WORKDIR}/IP2LOCATION-LITE-DB5.BIN"
}
