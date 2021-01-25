# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Module that provides a convenience wrapper around HTTP GET microservices"
HOMEPAGE="
	https://github.com/pelias/microservice-wrapper
	https://www.npmjs.com/package/pelias-microservice-wrapper
"
SRC_URI="https://registry.npmjs.org/pelias-microservice-wrapper/-/pelias-microservice-wrapper-1.9.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/lodash
	dev-node/pelias-logger
	dev-node/superagent
"
