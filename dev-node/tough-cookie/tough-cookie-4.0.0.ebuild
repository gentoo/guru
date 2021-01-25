# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="RFC6265 Cookies and Cookie Jar for node.js"
HOMEPAGE="
	https://github.com/salesforce/tough-cookie
	https://www.npmjs.com/package/tough-cookie
"
SRC_URI="https://registry.npmjs.org/tough-cookie/-/tough-cookie-4.0.0.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/psl
	dev-node/punycode
	dev-node/universalify
"
