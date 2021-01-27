# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A better forEach"
HOMEPAGE="
	https://github.com/Raynos/for-each
	https://www.npmjs.com/package/for-each
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-callable
"
