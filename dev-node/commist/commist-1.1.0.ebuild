# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Build your commands on minimist!"
HOMEPAGE="
	https://github.com/mcollina/commist
	https://www.npmjs.com/package/commist
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/leven
	dev-node/minimist
"
