# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Call a callback when a readable/writable/duplex stream has completed or failed."
HOMEPAGE="
	https://github.com/mafintosh/end-of-stream
	https://www.npmjs.com/package/end-of-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/once
"
