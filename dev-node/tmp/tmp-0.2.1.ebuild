# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Temporary file and directory creator"
HOMEPAGE="
	https://github.com/raszi/node-tmp
	https://www.npmjs.com/package/tmp
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/rimraf
"
