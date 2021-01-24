# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="utilities for primitive JavaScript types"
HOMEPAGE="
	https://github.com/joyent/node-jsprim
	https://www.npmjs.com/package/jsprim
"
SRC_URI="https://registry.npmjs.org/jsprim/-/jsprim-2.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
