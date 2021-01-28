# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A deep deletion module for node (like rm -rf)"
HOMEPAGE="
	https://github.com/isaacs/rimraf
	https://www.npmjs.com/package/rimraf
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
"
