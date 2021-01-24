# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Like which(1) unix command. Find the first instance of an executable in the PATH."
HOMEPAGE="
	https://github.com/isaacs/node-which
	https://www.npmjs.com/package/which
"
SRC_URI="https://registry.npmjs.org/which/-/which-2.0.2.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/isexe
"
