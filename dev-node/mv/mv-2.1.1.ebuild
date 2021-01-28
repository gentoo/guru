# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="fs.rename but works across devices. same as the unix utility 'mv'"
HOMEPAGE="
	https://github.com/andrewrk/node-mv
	https://www.npmjs.com/package/mv
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mkdirp
	dev-node/ncp
	dev-node/rimraf
"
