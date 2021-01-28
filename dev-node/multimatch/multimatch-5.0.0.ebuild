# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Extends minimatch.match() with support for multiple patterns"
HOMEPAGE="
	https://github.com/sindresorhus/multimatch
	https://www.npmjs.com/package/multimatch
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/types+minimatch
	dev-node/array-differ
	dev-node/array-union
	dev-node/arrify
	dev-node/minimatch
"
