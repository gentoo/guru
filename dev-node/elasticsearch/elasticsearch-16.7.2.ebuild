# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="The official low-level Elasticsearch client for Node.js and the browser."
HOMEPAGE="
	https://www.elastic.co/guide/en/elasticsearch/client/javascript-api/16.x/index.html
	https://www.npmjs.com/package/elasticsearch
"
SRC_URI="https://registry.npmjs.org/elasticsearch/-/elasticsearch-16.7.2.tgz"
LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/agentkeepalive
	dev-node/chalk
	dev-node/lodash
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}