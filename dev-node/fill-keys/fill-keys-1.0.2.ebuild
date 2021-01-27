# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Fill keys in a destination that are defined on the source"
HOMEPAGE="
	https://github.com/bendrucker/fill-keys
	https://www.npmjs.com/package/fill-keys
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-object
	dev-node/merge-descriptors
"
