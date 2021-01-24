# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A stable array sort for JavaScript"
HOMEPAGE="
	https://github.com/Two-Screen/stable
	https://www.npmjs.com/package/stable
"
SRC_URI="https://registry.npmjs.org/stable/-/stable-0.1.8.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
