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
	dev-js/detect-libc
	dev-js/expand-template
	dev-js/github-from-package
	dev-js/minimist
	dev-js/mkdirp-classic
	dev-js/napi-build-utils
	dev-js/node-abi
	dev-js/noop-logger
	dev-js/npmlog
	dev-js/pump
	dev-js/rc
	dev-js/simple-get
	dev-js/tar-fs
	dev-js/tunnel-agent
	dev-js/which-pm-runs
"
