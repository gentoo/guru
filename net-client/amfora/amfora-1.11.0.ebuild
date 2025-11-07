# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module xdg

DESCRIPTION="A fancy terminal browser for the Gemini protocol."
HOMEPAGE="https://github.com/makew0rld/amfora"
SRC_URI="https://github.com/makew0rld/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz"

LICENSE="0BSD Apache-2.0 BSD BSD-2 GPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( CHANGELOG.md NOTES.md README.md THANKS.md default-config.toml )

src_compile() {
	ego build -ldflags="-X main.version=${PV} -X main.builtBy=Gentoo" -o amfora
}

src_test() {
	ego test ./...
}

src_install() {
	dobin amfora
	doman amfora.1
	domenu amfora.desktop
}
