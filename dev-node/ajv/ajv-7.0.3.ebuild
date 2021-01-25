# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Another JSON Schema Validator"
HOMEPAGE="
	https://github.com/ajv-validator/ajv
	https://www.npmjs.com/package/ajv
"
SRC_URI="https://registry.npmjs.org/ajv/-/ajv-7.0.3.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/fast-deep-equal
	dev-node/json-schema-traverse
	dev-node/require-from-string
	dev-node/uri-js
"
