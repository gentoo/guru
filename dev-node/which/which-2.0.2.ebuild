# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Like which(1) unix command. Find the first instance of an executable in the PATH."
HOMEPAGE="
	https://github.com/isaacs/node-which
	https://www.npmjs.com/package/which
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/isexe
"
