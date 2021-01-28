# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Cross platform child_process#spawn and child_process#spawnSync"
HOMEPAGE="
	https://github.com/moxystudio/node-cross-spawn
	https://www.npmjs.com/package/cross-spawn
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/path-key
	dev-node/shebang-command
	dev-node/which
"
