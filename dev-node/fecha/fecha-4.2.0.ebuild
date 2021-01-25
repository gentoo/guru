# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Date formatting and parsing"
HOMEPAGE="
	https://github.com/taylorhakes/fecha
	https://www.npmjs.com/package/fecha
"
SRC_URI="https://registry.npmjs.org/fecha/-/fecha-4.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
