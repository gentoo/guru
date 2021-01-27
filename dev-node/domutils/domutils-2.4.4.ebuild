# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Utilities for working with htmlparser2's dom"
HOMEPAGE="
	https://github.com/fb55/domutils
	https://www.npmjs.com/package/domutils
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/dom-serializer
	dev-node/domelementtype
	dev-node/domhandler
"
