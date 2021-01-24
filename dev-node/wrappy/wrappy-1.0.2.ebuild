# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Callback wrapping utility"
HOMEPAGE="
	https://github.com/npm/wrappy
	https://www.npmjs.com/package/wrappy
"
SRC_URI="https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
