# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get your PATH prepended with locally installed binaries"
HOMEPAGE="
	https://github.com/sindresorhus/npm-run-path
	https://www.npmjs.com/package/npm-run-path
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/path-key
"
