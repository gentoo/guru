# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="ANSI escape codes for styling strings in the terminal"
HOMEPAGE="
	https://github.com/sindresorhus/ansi-styles
	https://www.npmjs.com/package/ansi-styles
"
SRC_URI="https://registry.npmjs.org/ansi-styles/-/ansi-styles-${PV}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
