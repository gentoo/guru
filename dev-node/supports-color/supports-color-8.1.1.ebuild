# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Detect whether a terminal supports color"
HOMEPAGE="
	https://github.com/chalk/supports-color
	https://www.npmjs.com/package/supports-color
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/has-flag
"