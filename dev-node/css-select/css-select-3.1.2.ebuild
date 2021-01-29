# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a CSS selector compiler/engine"
HOMEPAGE="
	https://github.com/fb55/css-select
	https://www.npmjs.com/package/css-select
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/boolbase
	dev-node/css-what
	dev-node/domhandler
	dev-node/domutils
	dev-node/nth-check
"
