# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The assert module from Node.js, for the browser."
HOMEPAGE="
	https://github.com/browserify/commonjs-assert
	https://www.npmjs.com/package/assert
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/es6-object-assign
	dev-js/is-nan
	dev-js/object-is
	dev-js/util
"
