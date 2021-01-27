# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Is this value a JS Typed Array? This module works cross-realm/iframe, does not depend on instanceof or mutable properties, and despite ES6 Symbol.toStringTag."
HOMEPAGE="
	https://github.com/inspect-js/is-typed-array
	https://www.npmjs.com/package/is-typed-array
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/available-typed-arrays
	dev-node/call-bind
	dev-node/es-abstract
	dev-node/foreach
	dev-node/has-symbols
"
