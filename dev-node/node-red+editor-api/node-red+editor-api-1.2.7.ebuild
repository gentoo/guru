# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="@node-red/editor-api ===================="
HOMEPAGE="
	https://github.com/node-red/node-red
	https://www.npmjs.com/package/@node-red/editor-api
"

PN_LEFT="${PN%%+*}"
PN_RIGHT="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${PN_LEFT}/${PN_RIGHT}/-/${PN_RIGHT}-${PV}.tgz -> ${P}.tgz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/node-red+util
	dev-node/node-red+editor-client
	dev-node/bcryptjs
	dev-node/body-parser
	dev-node/clone
	dev-node/cors
	dev-node/express-session
	dev-node/express
	dev-node/memorystore
	dev-node/mime
	dev-node/multer
	dev-node/mustache
	dev-node/oauth2orize
	dev-node/passport-http-bearer
	dev-node/passport-oauth2-client-password
	dev-node/passport
	dev-node/when
	dev-node/ws
	dev-node/bcrypt
"
