# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Feed aggregator for gemini supporting many formats and protocols"
HOMEPAGE="https://sr.ht/~nytpu/comitium/"
SRC_URI="https://git.sr.ht/~nytpu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sysrq-golang-dist/${PN}/releases/download/v${PV}/${P}-deps.tar.xz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="AGPL-3"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-text/scdoc"

DOCS=( doc/quickstart.{en,fr}.md doc/translating.en.md )

src_configure() {
	export GO="go"
	export GOLDFLAGS="-X golang.nytpu.com/comitium/core.Version=${PV} -X golang.nytpu.com/comitium/core.Commit=tarball"
	export PREFIX="${EPREFIX}/usr"
	go-module_src_configure
}
