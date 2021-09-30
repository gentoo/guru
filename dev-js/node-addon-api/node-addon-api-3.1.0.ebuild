# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js API (N-API)"
HOMEPAGE="
	https://github.com/nodejs/node-addon-api
	https://www.npmjs.com/package/node-addon-api
"

LICENSE="MIT"
KEYWORDS="~amd64"

src_install() {
	dodoc -r doc/.
	rm -rf doc || die
	node_src_install
}
