# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Serialize JavaScript to a superset of JSON that includes regular expressions and functions."
HOMEPAGE="
	https://github.com/yahoo/serialize-javascript
	https://www.npmjs.com/package/serialize-javascript
"
SRC_URI="https://registry.npmjs.org/serialize-javascript/-/serialize-javascript-5.0.1.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/randombytes
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}