# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Tool for transforming styles with JS plugins"
HOMEPAGE="
	https://postcss.org/
	https://www.npmjs.com/package/postcss
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/colorette
	dev-node/nanoid
	dev-node/source-map
"
