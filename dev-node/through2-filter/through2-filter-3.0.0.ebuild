# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A through2 to create an Array.prototype.filter analog for streams."
HOMEPAGE="
	https://github.com/brycebaril/through2-filter
	https://www.npmjs.com/package/through2-filter
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/through2
	dev-node/xtend
"