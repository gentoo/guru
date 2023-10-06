# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command line downloader for the Gemini protocol"
HOMEPAGE="https://github.com/makew0rld/gemget"

SRC_URI="https://github.com/makew0rld/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

LICENSE="0BSD BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_compile() {
	ego build -o ${PN} -ldflags="-s -w" || die
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
