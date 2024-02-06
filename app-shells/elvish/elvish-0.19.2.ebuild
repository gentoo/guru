# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Expressive programming language and a versatile interactive shell"
HOMEPAGE="https://elv.sh/"
SRC_URI="https://github.com/elves/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://gitlab.com/freijon_gentoo/${CATEGORY}/${PN}/-/raw/main/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="BSD-2"
# Additional licenses used in the package
LICENSE+=" BSD EPL-1.0 CC-BY-SA-4.0"

SLOT="0"
KEYWORDS="~amd64"

DOCS=(
	"README.md"
)
HTML_DOCS=(
	"website/learn"
	"website/ref"
)

src_compile() {
	ego build -ldflags "-X src.elv.sh/pkg/buildinfo.BuildVariant=gentoo-guru" "./cmd/${PN}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
