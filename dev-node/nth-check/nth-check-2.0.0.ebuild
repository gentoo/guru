# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parses and compiles CSS nth-checks to highly optimized functions."
HOMEPAGE="
	https://github.com/fb55/nth-check
	https://www.npmjs.com/package/nth-check
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/boolbase
"
