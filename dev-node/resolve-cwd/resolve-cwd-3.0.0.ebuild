# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Resolve the path of a module like require.resolve() but from the current working directory"
HOMEPAGE="
	https://github.com/sindresorhus/resolve-cwd
	https://www.npmjs.com/package/resolve-cwd
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/resolve-from
"
