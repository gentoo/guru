# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="simple persistent cookiejar system"
HOMEPAGE="
	https://github.com/bmeck/node-cookiejar
	https://www.npmjs.com/package/cookiejar
"
SRC_URI="https://registry.npmjs.org/cookiejar/-/cookiejar-2.1.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
