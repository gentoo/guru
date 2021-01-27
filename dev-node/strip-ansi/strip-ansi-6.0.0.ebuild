# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Strip ANSI escape codes from a string"
HOMEPAGE="
	https://github.com/chalk/strip-ansi
	https://www.npmjs.com/package/strip-ansi
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ansi-regex
"