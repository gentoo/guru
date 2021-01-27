# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The official low-level Elasticsearch client for Node.js and the browser."
HOMEPAGE="
	https://www.elastic.co/guide/en/elasticsearch/client/javascript-api/16.x/index.html
	https://www.npmjs.com/package/elasticsearch
"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/agentkeepalive
	dev-node/chalk
	dev-node/lodash
"