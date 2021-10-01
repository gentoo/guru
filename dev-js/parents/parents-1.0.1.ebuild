# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="return all the parent directories for a directory"
HOMEPAGE="
	https://github.com/substack/node-parents
	https://www.npmjs.com/package/parents
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/path-platform
"
