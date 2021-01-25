# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Strip ANSI escape codes from a string"
HOMEPAGE="
	https://github.com/chalk/strip-ansi
	https://www.npmjs.com/package/strip-ansi
"
SRC_URI="https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/ansi-regex
"
