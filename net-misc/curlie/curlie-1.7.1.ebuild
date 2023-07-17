# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Curlie is a frontend to curl that adds the ease of use of httpie"
HOMEPAGE="https://curlie.io/"
SRC_URI="https://github.com/rs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://kdrive.infomaniak.com/2/app/192129/share/74ab6733-4354-4f97-84b5-8f270ff9e4f6/files/22/download -> ${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	net-misc/curl
"
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
