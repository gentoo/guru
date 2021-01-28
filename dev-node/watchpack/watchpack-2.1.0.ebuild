# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Wrapper library for directory and file watching."
HOMEPAGE="
	https://github.com/webpack/watchpack
	https://www.npmjs.com/package/watchpack
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob-to-regexp
	dev-node/graceful-fs
"
