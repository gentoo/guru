# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Another JSON Schema Validator"
HOMEPAGE="
	https://github.com/ajv-validator/ajv
	https://www.npmjs.com/package/ajv
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/fast-deep-equal
	dev-js/json-schema-traverse
	dev-js/require-from-string
	dev-js/uri-js
"

src_install() {
	dodoc -r docs/.
	rm -r docs || die
	node_src_install
}
