# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Fixes stack traces for files with source maps"
HOMEPAGE="
	https://github.com/evanw/node-source-map-support
	https://www.npmjs.com/package/source-map-support
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/buffer-from
	dev-node/source-map
"
