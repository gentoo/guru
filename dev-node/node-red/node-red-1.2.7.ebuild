# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Low-code programming for event-driven applications"
HOMEPAGE="
	https://nodered.org
	https://www.npmjs.com/package/node-red
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/node-red+editor-api
	dev-node/node-red+runtime
	dev-node/node-red+util
	dev-node/node-red+nodes
	dev-node/basic-auth
	dev-node/bcryptjs
	dev-node/express
	dev-node/fs-extra
	dev-node/node-red-admin
	dev-node/node-red-node-rbe
	dev-node/node-red-node-tail
	dev-node/nopt
	dev-node/semver
	dev-node/bcrypt
"
