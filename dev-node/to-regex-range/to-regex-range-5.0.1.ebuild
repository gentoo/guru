# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Pass two numbers, get a regex-compatible source string for matching ranges. Validated against more than 2.78 million test assertions."
HOMEPAGE="
	https://github.com/micromatch/to-regex-range
	https://www.npmjs.com/package/to-regex-range
"
SRC_URI="https://registry.npmjs.org/to-regex-range/-/to-regex-range-5.0.1.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/is-number
"
