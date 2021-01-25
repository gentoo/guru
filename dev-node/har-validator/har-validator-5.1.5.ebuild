# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Extremely fast HTTP Archive (HAR) validator using JSON Schema"
HOMEPAGE="
	https://github.com/ahmadnassri/node-har-validator
	https://www.npmjs.com/package/har-validator
"
SRC_URI="https://registry.npmjs.org/har-validator/-/har-validator-5.1.5.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/ajv
	dev-node/har-schema
"
