# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Check and get file hashes"
HOMEPAGE="
	https://github.com/ForbesLindesay/sha
	https://www.npmjs.com/package/sha
"
LICENSE="|| ( BSD-2 MIT )"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/graceful-fs
"