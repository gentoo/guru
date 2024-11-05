# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="scc is a very fast accurate code counter"
HOMEPAGE="https://github.com/boyter/scc/tree/master"
SRC_URI="https://github.com/boyter/scc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
DOCS="CONTRIBUTING.md LANGUAGES.md README.md examples"

src_compile() {
	go build
}

src_install() {
	dobin scc
	einstalldocs
}
