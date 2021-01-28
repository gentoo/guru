# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Recursively (deep) clone JavaScript native types, like Object, Array, RegExp, Date as well as primitives."
HOMEPAGE="
	https://github.com/jonschlinkert/clone-deep
	https://www.npmjs.com/package/clone-deep
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-plain-object
	dev-node/kind-of
	dev-node/shallow-clone
"
