# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Process execution for humans"
HOMEPAGE="
	https://github.com/sindresorhus/execa
	https://www.npmjs.com/package/execa
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cross-spawn
	dev-node/get-stream
	dev-node/human-signals
	dev-node/is-stream
	dev-node/merge-stream
	dev-node/npm-run-path
	dev-node/onetime
	dev-node/signal-exit
	dev-node/strip-final-newline
"
