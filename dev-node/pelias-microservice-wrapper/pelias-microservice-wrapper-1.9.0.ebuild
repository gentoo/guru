# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Module that provides a convenience wrapper around HTTP GET microservices"
HOMEPAGE="
	https://github.com/pelias/microservice-wrapper
	https://www.npmjs.com/package/pelias-microservice-wrapper
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/lodash
	dev-node/pelias-logger
	dev-node/superagent
"
