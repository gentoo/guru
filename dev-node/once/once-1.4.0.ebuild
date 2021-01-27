# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Run a function exactly one time"
HOMEPAGE="
	https://github.com/isaacs/once
	https://www.npmjs.com/package/once
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/wrappy
"