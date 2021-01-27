# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Unicode symbols with Windows CMD fallbacks"
HOMEPAGE="
	https://github.com/sindresorhus/figures
	https://www.npmjs.com/package/figures
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/escape-string-regexp
"
