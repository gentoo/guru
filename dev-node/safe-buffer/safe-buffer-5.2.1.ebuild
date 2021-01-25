# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Safer Node.js Buffer API"
HOMEPAGE="
	https://github.com/feross/safe-buffer
	https://www.npmjs.com/package/safe-buffer
"
SRC_URI="https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
