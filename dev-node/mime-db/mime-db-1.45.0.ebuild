# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Media Type Database"
HOMEPAGE="
	https://github.com/jshttp/mime-db
	https://www.npmjs.com/package/mime-db
"
SRC_URI="https://registry.npmjs.org/mime-db/-/mime-db-1.45.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
