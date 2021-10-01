# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="node style md5 on pure JavaScript"
HOMEPAGE="
	https://github.com/crypto-browserify/md5.js
	https://www.npmjs.com/package/md5.js
"

MYPN="${PN//_/.}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hash-base
	dev-js/inherits
	dev-js/safe-buffer
"
