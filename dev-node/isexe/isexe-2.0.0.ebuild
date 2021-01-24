# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Minimal module to check if a file is executable."
HOMEPAGE="
	https://github.com/isaacs/isexe
	https://www.npmjs.com/package/isexe
"
SRC_URI="https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
