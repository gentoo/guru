# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="node's assert.deepEqual algorithm"
HOMEPAGE="
	https://github.com/inspect-js/node-deep-equal
	https://www.npmjs.com/package/deep-equal
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/call-bind
	dev-js/es-get-iterator
	dev-js/get-intrinsic
	dev-js/is-arguments
	dev-js/is-date-object
	dev-js/is-regex
	dev-js/isarray
	dev-js/object-is
	dev-js/object-keys
	dev-js/object_assign
	dev-js/regexp_prototype_flags
	dev-js/side-channel
	dev-js/which-boxed-primitive
	dev-js/which-collection
	dev-js/which-typed-array
"
