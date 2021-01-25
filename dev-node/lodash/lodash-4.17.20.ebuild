# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Lodash modular utilities."
HOMEPAGE="
	https://lodash.com/
	https://www.npmjs.com/package/lodash
"
SRC_URI="https://registry.npmjs.org/lodash/-/lodash-4.17.20.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
