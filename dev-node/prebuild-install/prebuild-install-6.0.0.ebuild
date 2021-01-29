# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A command line tool to easily install prebuilt binaries for multiple version of node/iojs on a specific platform"
HOMEPAGE="
	https://github.com/prebuild/prebuild-install
	https://www.npmjs.com/package/prebuild-install
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/detect-libc
	dev-node/expand-template
	dev-node/github-from-package
	dev-node/minimist
	dev-node/mkdirp-classic
	dev-node/napi-build-utils
	dev-node/node-abi
	dev-node/noop-logger
	dev-node/npmlog
	dev-node/pump
	dev-node/rc
	dev-node/simple-get
	dev-node/tar-fs
	dev-node/tunnel-agent
	dev-node/which-pm-runs
"
