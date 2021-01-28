# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Package to help in popular typo: browserlist instead of browserslist"
HOMEPAGE="
	https://github.com/browserslist/typo
	https://www.npmjs.com/package/browserlist
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/chalk
"
