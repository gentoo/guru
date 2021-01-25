# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Return the filename and line number of the calling function"
HOMEPAGE="
	https://github.com/sideway/pinpoint
	https://www.npmjs.com/package/@sideway/pinpoint
"
SRC_URI="https://registry.npmjs.org/@sideway/pinpoint/-/pinpoint-2.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
