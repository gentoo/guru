# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Check if the character represented by a given Unicode code point is fullwidth"
HOMEPAGE="
	https://github.com/sindresorhus/is-fullwidth-code-point
	https://www.npmjs.com/package/is-fullwidth-code-point
"
SRC_URI="https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
