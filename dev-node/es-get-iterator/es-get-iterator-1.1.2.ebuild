# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get an iterator for any JS language value. Works robustly across all environments, all versions."
HOMEPAGE="
	https://github.com/ljharb/es-get-iterator
	https://www.npmjs.com/package/es-get-iterator
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/call-bind
	dev-node/get-intrinsic
	dev-node/has-symbols
	dev-node/is-arguments
	dev-node/is-map
	dev-node/is-set
	dev-node/is-string
	dev-node/isarray
"
