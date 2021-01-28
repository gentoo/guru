# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Terser plugin for webpack"
HOMEPAGE="
	https://github.com/webpack-contrib/terser-webpack-plugin
	https://www.npmjs.com/package/terser-webpack-plugin
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jest-worker
	dev-node/p-limit
	dev-node/schema-utils
	dev-node/serialize-javascript
	dev-node/source-map
	dev-node/terser
"
