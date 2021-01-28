# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Implementation of JSON Web Signatures"
HOMEPAGE="
	https://github.com/brianloveswords/node-jws
	https://www.npmjs.com/package/jws
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jwa
	dev-node/safe-buffer
"
