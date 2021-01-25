# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="the mighty option parser used by yargs"
HOMEPAGE="
	https://github.com/yargs/yargs-parser
	https://www.npmjs.com/package/yargs-parser
"
SRC_URI="https://registry.npmjs.org/yargs-parser/-/yargs-parser-20.2.4.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
