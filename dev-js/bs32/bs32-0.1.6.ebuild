# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Base32 for javascript"
HOMEPAGE="
	https://github.com/bcoin-org/bs32
	https://www.npmjs.com/package/bs32
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
"
