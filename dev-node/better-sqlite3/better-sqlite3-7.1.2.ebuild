# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The fastest and simplest library for SQLite3 in Node.js."
HOMEPAGE="
	https://github.com/JoshuaWise/better-sqlite3
	https://www.npmjs.com/package/better-sqlite3
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/bindings
	dev-node/detect-libc
	dev-node/napi-build-utils
	dev-node/node-abi
	dev-node/npmlog
	dev-node/object-assign
	dev-node/prebuild-install
	dev-node/pump
	dev-node/rc
	dev-node/simple-get
	dev-node/tar
	dev-node/which-pm-runs
"
