# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A node cli to control Firefox"
HOMEPAGE="
	https://github.com/mozilla-jetpack/node-fx-runner
	https://www.npmjs.com/package/fx-runner
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/commander
	dev-node/shell-quote
	dev-node/spawn-sync
	dev-node/when
	dev-node/which
	dev-node/winreg
"
