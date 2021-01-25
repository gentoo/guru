# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="tar for node"
HOMEPAGE="
	https://github.com/npm/node-tar
	https://www.npmjs.com/package/tar
"
SRC_URI="https://registry.npmjs.org/tar/-/tar-6.1.0.tgz -> ${P}.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
