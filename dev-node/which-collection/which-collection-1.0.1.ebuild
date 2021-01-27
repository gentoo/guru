# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Which kind of Collection (Map, Set, WeakMap, WeakSet) is this JavaScript value? Works cross-realm, without instanceof, and despite Symbol.toStringTag."
HOMEPAGE="
	https://github.com/inspect-js/which-collection
	https://www.npmjs.com/package/which-collection
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-map
	dev-node/is-set
	dev-node/is-weakmap
	dev-node/is-weakset
"
