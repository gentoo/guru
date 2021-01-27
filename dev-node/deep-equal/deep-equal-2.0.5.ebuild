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
	dev-node/call-bind
	dev-node/es-get-iterator
	dev-node/get-intrinsic
	dev-node/is-arguments
	dev-node/is-date-object
	dev-node/is-regex
	dev-node/isarray
	dev-node/object-is
	dev-node/object-keys
	dev-node/object_assign
	dev-node/regexp_prototype_flags
	dev-node/side-channel
	dev-node/which-boxed-primitive
	dev-node/which-collection
	dev-node/which-typed-array
"
