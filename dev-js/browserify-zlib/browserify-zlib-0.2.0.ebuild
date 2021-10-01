# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Full zlib module for the browser"
HOMEPAGE="
	https://github.com/devongovett/browserify-zlib
	https://www.npmjs.com/package/browserify-zlib
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/pako
"
