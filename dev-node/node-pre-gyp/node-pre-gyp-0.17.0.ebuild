# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js native addon binary install tool"
HOMEPAGE="
	https://github.com/mapbox/node-pre-gyp
	https://www.npmjs.com/package/node-pre-gyp
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/detect-libc
	dev-node/mkdirp
	dev-node/needle
	dev-node/nopt
	dev-node/npm-packlist
	dev-node/npmlog
	dev-node/rc
	dev-node/rimraf
	dev-node/semver
	dev-node/tar
"
