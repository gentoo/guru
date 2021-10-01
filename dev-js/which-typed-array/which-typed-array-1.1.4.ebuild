# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Which kind of Typed Array is this JavaScript value? Works cross-realm, without instanceof, and despite Symbol.toStringTag."
HOMEPAGE="
	https://github.com/inspect-js/which-typed-array
	https://www.npmjs.com/package/which-typed-array
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/available-typed-arrays
	dev-js/call-bind
	dev-js/es-abstract
	dev-js/foreach
	dev-js/function-bind
	dev-js/has-symbols
	dev-js/is-typed-array
"
