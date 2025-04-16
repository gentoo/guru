# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Multi-shell multi-command argument completer"
HOMEPAGE="https://carapace.sh/"
SRC_URI="https://github.com/${PN}-sh/${PN}-bin/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

DEPS_URI="https://github.com/freijon/${PN}-bin/releases/download/v${PV}/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

S="${WORKDIR}/${PN}-bin-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-lang/go-1.23.1
"

DOCS=(
	"README.md"
)
HTML_DOCS=(
	"docs/book/"
)

src_compile() {
	pushd "cmd/${PN}"
	ego generate ./...
	ego build -ldflags="-s -w" -tags release
}

src_install() {
	dobin "cmd/${PN}/${PN}"
	mv "docs/src" "docs/book" || die
	rm -r "docs/book/release_notes" || die
	einstalldocs
}
