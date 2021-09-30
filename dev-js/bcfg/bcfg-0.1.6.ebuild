# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Config parser for bcoin"
HOMEPAGE="
	https://github.com/bcoin-org/bcfg
	https://www.npmjs.com/package/bcfg
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
"
