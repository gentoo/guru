# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="minimal implementation of a PassThrough stream"
HOMEPAGE="
	https://github.com/isaacs/minipass
	https://www.npmjs.com/package/minipass
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/yallist
"
