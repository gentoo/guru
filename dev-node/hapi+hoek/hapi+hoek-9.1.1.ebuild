# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="General purpose node utilities"
HOMEPAGE="
	https://github.com/hapijs/hoek
	https://www.npmjs.com/package/@hapi/hoek
"
SRC_URI="https://registry.npmjs.org/@hapi/hoek/-/hoek-9.1.1.tgz -> ${P}.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
