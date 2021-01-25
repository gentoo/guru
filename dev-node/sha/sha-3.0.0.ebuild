# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Check and get file hashes"
HOMEPAGE="
	https://github.com/ForbesLindesay/sha
	https://www.npmjs.com/package/sha
"
SRC_URI="https://registry.npmjs.org/sha/-/sha-3.0.0.tgz"
LICENSE="|| ( BSD-2 MIT )"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/graceful-fs
"
