# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="check whether a command line command exists in the current environment"
HOMEPAGE="
	https://github.com/mathisonian/command-exists
	https://www.npmjs.com/package/command-exists
"
SRC_URI="https://registry.npmjs.org/command-exists/-/command-exists-1.2.9.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
