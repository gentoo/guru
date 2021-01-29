# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A stupidly simple key/value storage using files to persist some data"
HOMEPAGE="
	https://github.com/royriojas/flat-cache
	https://www.npmjs.com/package/flat-cache
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/flatted
	dev-node/rimraf
"
