# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="the stream module from node core for browsers"
HOMEPAGE="
	https://github.com/browserify/stream-browserify
	https://www.npmjs.com/package/stream-browserify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/readable-stream
"
