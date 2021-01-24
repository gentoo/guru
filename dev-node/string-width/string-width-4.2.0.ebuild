# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Get the visual width of a string - the number of columns required to display it"
HOMEPAGE="
	https://github.com/sindresorhus/string-width
	https://www.npmjs.com/package/string-width
"
SRC_URI="https://registry.npmjs.org/string-width/-/string-width-4.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/emoji-regex
	dev-node/is-fullwidth-code-point
	dev-node/strip-ansi
"
