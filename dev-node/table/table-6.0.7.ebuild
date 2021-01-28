# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Formats data into a string table."
HOMEPAGE="
	https://github.com/gajus/table
	https://www.npmjs.com/package/table
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ajv
	dev-node/lodash
	dev-node/slice-ansi
	dev-node/string-width
"
