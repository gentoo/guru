# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A through2 to create an Array.prototype.map analog for streams."
HOMEPAGE="
	https://github.com/brycebaril/through2-map
	https://www.npmjs.com/package/through2-map
"
SRC_URI="https://registry.npmjs.org/through2-map/-/through2-map-3.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/through2
	dev-node/xtend
"
