# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Check if argv has a specific flag"
HOMEPAGE="
	https://github.com/sindresorhus/has-flag
	https://www.npmjs.com/package/has-flag
"
SRC_URI="https://registry.npmjs.org/has-flag/-/has-flag-4.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
