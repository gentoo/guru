# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The Node-RED admin command line interface"
HOMEPAGE="
	http://nodered.org
	https://www.npmjs.com/package/node-red-admin
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/axios
	dev-node/bcryptjs
	dev-node/cli-table
	dev-node/minimist
	dev-node/read
	dev-node/bcrypt
"
