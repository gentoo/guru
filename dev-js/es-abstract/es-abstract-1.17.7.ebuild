# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ECMAScript spec abstract operations."
HOMEPAGE="
	https://github.com/ljharb/es-abstract
	https://www.npmjs.com/package/es-abstract
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/es-to-primitive
	dev-js/function-bind
	dev-js/has
	dev-js/has-symbols
	dev-js/is-callable
	dev-js/is-regex
	dev-js/object-inspect
	dev-js/object-keys
	dev-js/object_assign
	dev-js/string_prototype_trimend
	dev-js/string_prototype_trimstart
"
