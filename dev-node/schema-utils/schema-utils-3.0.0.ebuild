# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="webpack Validation Utils"
HOMEPAGE="
	https://github.com/webpack/schema-utils
	https://www.npmjs.com/package/schema-utils
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ajv
	dev-node/ajv-keywords
	dev-node/types+json-schema
"
