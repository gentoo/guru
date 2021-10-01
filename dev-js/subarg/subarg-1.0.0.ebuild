# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="parse arguments with recursive contexts"
HOMEPAGE="
	https://github.com/substack/subarg
	https://www.npmjs.com/package/subarg
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/minimist
"
