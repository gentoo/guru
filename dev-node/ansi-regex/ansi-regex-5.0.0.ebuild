# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Regular expression for matching ANSI escape codes"
HOMEPAGE="
	https://github.com/chalk/ansi-regex
	https://www.npmjs.com/package/ansi-regex
"
SRC_URI="https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
