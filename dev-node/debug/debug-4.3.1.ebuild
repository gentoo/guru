# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="small debugging utility"
HOMEPAGE="
	https://github.com/visionmedia/debug
	https://www.npmjs.com/package/debug
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ms
"