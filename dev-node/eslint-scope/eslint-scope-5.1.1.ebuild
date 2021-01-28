# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ECMAScript scope analyzer for ESLint"
HOMEPAGE="
	https://github.com/eslint/eslint-scope
	https://www.npmjs.com/package/eslint-scope
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/esrecurse
	dev-node/estraverse
"
