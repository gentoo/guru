# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ECC JS code based on JSBN"
HOMEPAGE="
	https://github.com/quartzjer/ecc-jsbn
	https://www.npmjs.com/package/ecc-jsbn
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/jsbn
"
