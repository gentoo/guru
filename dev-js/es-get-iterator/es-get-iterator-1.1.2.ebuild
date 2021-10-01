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
	dev-js/call-bind
	dev-js/get-intrinsic
	dev-js/has-symbols
	dev-js/is-arguments
	dev-js/is-map
	dev-js/is-set
	dev-js/is-string
	dev-js/isarray
"
