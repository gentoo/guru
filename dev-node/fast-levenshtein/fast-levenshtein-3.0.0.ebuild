# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Efficient implementation of Levenshtein algorithm  with locale-specific collator support."
HOMEPAGE="
	https://github.com/hiddentao/fast-levenshtein
	https://www.npmjs.com/package/fast-levenshtein
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fastest-levenshtein
"
