# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A basic but performant promise implementation"
HOMEPAGE="
	https://github.com/calvinmetcalf/lie
	https://www.npmjs.com/package/lie
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/immediate
"
