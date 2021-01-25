# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Traverse JSON Schema passing each schema object to callback"
HOMEPAGE="
	https://github.com/epoberezkin/json-schema-traverse
	https://www.npmjs.com/package/json-schema-traverse
"
SRC_URI="https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-1.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
