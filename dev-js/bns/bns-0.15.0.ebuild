# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="DNS bike-shed"
HOMEPAGE="
	https://github.com/chjj/bns
	https://www.npmjs.com/package/bns
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bcrypto
	dev-js/bfile
	dev-js/bheep
	dev-js/binet
	dev-js/bs32
	dev-js/bsert
	dev-js/btcp
	dev-js/budp
	dev-js/bufio
	dev-js/unbound
"
