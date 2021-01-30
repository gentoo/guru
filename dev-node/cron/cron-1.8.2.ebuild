# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Cron jobs for your node"
HOMEPAGE="
	https://github.com/kelektiv/node-cron
	https://www.npmjs.com/package/cron
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/moment-timezone
"
