# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="small debugging utility"
HOMEPAGE="
	https://github.com/visionmedia/debug
	https://www.npmjs.com/package/debug
"
SRC_URI="https://registry.npmjs.org/debug/-/debug-4.3.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/ms
"
