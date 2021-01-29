# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="JavaScript library for color conversions"
HOMEPAGE="
	https://github.com/gka/chroma.js
	https://www.npmjs.com/package/chroma-js
"

LICENSE="BSD Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cross-env
"
