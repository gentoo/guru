# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Curlie is a frontend to curl that adds the ease of use of httpie"
HOMEPAGE="https://curlie.io/"
SRC_URI="https://github.com/rs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://gitlab.com/freijon_gentoo/${CATEGORY}/${PN}/-/raw/main/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-misc/curl
"
RDEPEND="${DEPEND}"

src_compile() {
	ego build .
}

src_install() {
	dobin ${PN}
	dodoc "README.md"
	default
}
