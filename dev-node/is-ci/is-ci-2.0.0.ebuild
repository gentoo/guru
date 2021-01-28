# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Detect if the current environment is a CI server"
HOMEPAGE="
	https://github.com/watson/is-ci
	https://www.npmjs.com/package/is-ci
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ci-info
"
