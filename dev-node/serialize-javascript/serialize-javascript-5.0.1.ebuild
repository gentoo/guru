# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Serialize JavaScript to a superset of JSON that includes regular expressions and functions."
HOMEPAGE="
	https://github.com/yahoo/serialize-javascript
	https://www.npmjs.com/package/serialize-javascript
"
SRC_URI="https://registry.npmjs.org/serialize-javascript/-/serialize-javascript-5.0.1.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/randombytes
"
