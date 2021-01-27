# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="RFC6265 Cookies and Cookie Jar for node.js"
HOMEPAGE="
	https://github.com/salesforce/tough-cookie
	https://www.npmjs.com/package/tough-cookie
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/psl
	dev-node/punycode
	dev-node/universalify
"