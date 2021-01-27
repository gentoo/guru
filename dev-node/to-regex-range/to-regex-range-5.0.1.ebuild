# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Pass two numbers, get a regex-compatible source string for matching ranges. Validated against more than 2.78 million test assertions."
HOMEPAGE="
	https://github.com/micromatch/to-regex-range
	https://www.npmjs.com/package/to-regex-range
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-number
"