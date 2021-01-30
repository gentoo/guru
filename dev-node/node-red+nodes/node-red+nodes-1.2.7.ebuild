# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="@node-red/nodes ===================="
HOMEPAGE="
	https://github.com/node-red/node-red
	https://www.npmjs.com/package/@node-red/nodes
"

PN_LEFT="${PN%%+*}"
PN_RIGHT="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${PN_LEFT}/${PN_RIGHT}/-/${PN_RIGHT}-${PV}.tgz -> ${P}.tgz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ajv
	dev-node/body-parser
	dev-node/cheerio
	dev-node/content-type
	dev-node/cookie-parser
	dev-node/cookie
	dev-node/cors
	dev-node/cron
	dev-node/denque
	dev-node/fs-extra
	dev-node/fs_notify
	dev-node/hash-sum
	dev-node/https-proxy-agent
	dev-node/is-utf8
	dev-node/js-yaml
	dev-node/media-typer
	dev-node/mqtt
	dev-node/multer
	dev-node/mustache
	dev-node/on-headers
	dev-node/raw-body
	dev-node/request
	dev-node/ws
	dev-node/xml2js
	dev-node/iconv-lite
"
