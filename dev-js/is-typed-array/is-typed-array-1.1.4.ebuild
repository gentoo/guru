# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Is this value a JS Typed Array?"
HOMEPAGE="
	https://github.com/inspect-js/is-typed-array
	https://www.npmjs.com/package/is-typed-array
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/available-typed-arrays
	dev-js/call-bind
	dev-js/es-abstract
	dev-js/foreach
	dev-js/has-symbols
"
