# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="List of binary file extensions"
HOMEPAGE="
	https://github.com/sindresorhus/binary-extensions
	https://www.npmjs.com/package/binary-extensions
"
SRC_URI="https://registry.npmjs.org/binary-extensions/-/binary-extensions-2.2.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
