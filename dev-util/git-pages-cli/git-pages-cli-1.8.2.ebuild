# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command-line application for publishing sites to git-pages"
HOMEPAGE="https://codeberg.org/git-pages/git-pages-cli"
SRC_URI="https://codeberg.org/git-pages/git-pages-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
		 https://files.demize.dev/gentoo/${CATEGORY}/${PN}/${P}-vendor.tar.xz"

S="${WORKDIR}/${PN}"

LICENSE="0BSD"
# dependencies
LICENSE+=" Apache-2.0 BSD MIT "
SLOT="0"
KEYWORDS="~amd64"

# project specifies a minimum Go version of 1.25
BDEPEND+=">=dev-lang/go-1.25.0:="

DOCS=( README.md )

src_compile() {
	ego build
}

src_install() {
	dobin git-pages-cli
	einstalldocs
}
