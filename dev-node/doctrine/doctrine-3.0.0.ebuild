# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="JSDoc parser"
HOMEPAGE="
	https://github.com/eslint/doctrine
	https://www.npmjs.com/package/doctrine
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/esutils
"
