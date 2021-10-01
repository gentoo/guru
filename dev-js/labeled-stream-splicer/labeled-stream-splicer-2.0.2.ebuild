# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="stream splicer with labels"
HOMEPAGE="
	https://github.com/browserify/labeled-stream-splicer
	https://www.npmjs.com/package/labeled-stream-splicer
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/stream-splicer
"
