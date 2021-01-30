# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Help command for node, partner of minimist and commist"
HOMEPAGE="
	https://github.com/mcollina/help-me
	https://www.npmjs.com/package/help-me
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
	dev-node/readable-stream
"
