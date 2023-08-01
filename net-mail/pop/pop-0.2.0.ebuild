# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Send emails from your terminal"
HOMEPAGE="https://github.com/charmbracelet/pop"
SRC_URI="https://github.com/charmbracelet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://gitlab.com/freijon_gentoo/${CATEGORY}/${PN}/uploads/7f29f486dd58e399fd05ca93587660c5/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/go
"

src_compile() {
	ego build .
}

src_install() {
	dobin ${PN}
	dodoc "README.md"
	default
}
