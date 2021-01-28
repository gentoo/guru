# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Module for executing heavy tasks under forked processes in parallel, by providing a Promise based interface, minimum overhead, and bound workers."
HOMEPAGE="
	https://github.com/facebook/jest
	https://www.npmjs.com/package/jest-worker
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/types+node
	dev-node/merge-stream
	dev-node/supports-color
"
