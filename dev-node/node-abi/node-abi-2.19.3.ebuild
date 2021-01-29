# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the Node ABI for a given target and runtime, and vice versa."
HOMEPAGE="
	https://github.com/lgeiger/node-abi
	https://www.npmjs.com/package/node-abi
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/semver
"
