# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js's util module for all engines"
HOMEPAGE="
	https://github.com/browserify/node-util
	https://www.npmjs.com/package/util
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/is-arguments
	dev-js/is-generator-function
	dev-js/is-typed-array
	dev-js/safe-buffer
	dev-js/which-typed-array
"
