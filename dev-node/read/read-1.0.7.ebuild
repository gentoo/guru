# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="read(1) for node programs"
HOMEPAGE="
	https://github.com/isaacs/read
	https://www.npmjs.com/package/read
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mute-stream
"
