# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Run scripts that set and use environment variables across platforms"
HOMEPAGE="
	https://github.com/kentcdodds/cross-env
	https://www.npmjs.com/package/cross-env
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cross-spawn
"
