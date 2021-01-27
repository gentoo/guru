# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Serialize JavaScript to a superset of JSON that includes regular expressions and functions."
HOMEPAGE="
	https://github.com/yahoo/serialize-javascript
	https://www.npmjs.com/package/serialize-javascript
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/randombytes
"