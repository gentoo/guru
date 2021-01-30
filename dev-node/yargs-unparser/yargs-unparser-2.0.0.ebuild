# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Converts back a yargs argv object to its original array form"
HOMEPAGE="
	https://github.com/yargs/yargs-unparser
	https://www.npmjs.com/package/yargs-unparser
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/camelcase
	dev-node/decamelize
	dev-node/flat
	dev-node/is-plain-obj
"
