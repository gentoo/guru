# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Easily read/write JSON files."
HOMEPAGE="
	https://github.com/jprichardson/node-jsonfile
	https://www.npmjs.com/package/jsonfile
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/universalify
	dev-node/graceful-fs
"
