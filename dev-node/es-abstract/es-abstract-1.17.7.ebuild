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
	dev-node/es-to-primitive
	dev-node/function-bind
	dev-node/has
	dev-node/has-symbols
	dev-node/is-callable
	dev-node/is-regex
	dev-node/object-inspect
	dev-node/object-keys
	dev-node/object_assign
	dev-node/string_prototype_trimend
	dev-node/string_prototype_trimstart
"
