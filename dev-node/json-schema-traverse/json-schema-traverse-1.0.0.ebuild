# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Traverse JSON Schema passing each schema object to callback"
HOMEPAGE="
	https://github.com/epoberezkin/json-schema-traverse
	https://www.npmjs.com/package/json-schema-traverse
"
SRC_URI="https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-1.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-misc/jq
	sys-apps/moreutils
"
S="${WORKDIR}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/json-schema-traverse"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}