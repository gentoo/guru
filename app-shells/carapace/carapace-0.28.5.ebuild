# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Multi-shell multi-command argument completer"
HOMEPAGE="https://rsteube.github.io/carapace-bin/"
SRC_URI="https://github.com/rsteube/${PN}-bin/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://gitlab.com/freijon_gentoo/${CATEGORY}/${PN}/-/raw/main/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-bin-${PV}"

src_compile() {
	pushd "cmd/${PN}"
	ego generate ./...
	ego build -ldflags="-s -w" -tags release
}

src_install() {
	dobin "cmd/${PN}/${PN}"
	mv "docs/src" "docs/book" || die
	rm -r "docs/book/changelog" || die
	dodoc "README.md"
	dodoc -r "docs/book"
}
