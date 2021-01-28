# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="$merge and $patch keywords for Ajv JSON-Schema validator to extend schemas"
HOMEPAGE="
	https://github.com/epoberezkin/ajv-merge-patch
	https://www.npmjs.com/package/ajv-merge-patch
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fast-json-patch
	dev-node/json-merge-patch
"
