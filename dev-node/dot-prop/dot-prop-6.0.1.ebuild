# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get, set, or delete a property from a nested object using a dot path"
HOMEPAGE="
	https://github.com/sindresorhus/dot-prop
	https://www.npmjs.com/package/dot-prop
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-obj
"
