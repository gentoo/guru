# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="An RFC 3986/3987 compliant, scheme extendable URI/IRI parsing/validating/resolving library for JavaScript."
HOMEPAGE="
	https://github.com/garycourt/uri-js
	https://www.npmjs.com/package/uri-js
"
SRC_URI="https://registry.npmjs.org/uri-js/-/uri-js-4.4.1.tgz -> ${P}.tgz"
LICENSE="BSD-2"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/uri-js"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}