# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Find a file or directory by walking up parent directories"
HOMEPAGE="
	https://github.com/sindresorhus/find-up
	https://www.npmjs.com/package/find-up
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/locate-path
	dev-node/path-exists
"