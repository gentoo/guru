# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="JSON Schema for HTTP Archive (HAR)"
HOMEPAGE="
	https://github.com/ahmadnassri/har-schema
	https://www.npmjs.com/package/har-schema
"
SRC_URI="https://registry.npmjs.org/har-schema/-/har-schema-2.0.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
