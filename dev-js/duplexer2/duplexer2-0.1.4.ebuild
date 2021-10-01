# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Like duplexer but using streams3"
HOMEPAGE="
	https://github.com/deoxxa/duplexer2
	https://www.npmjs.com/package/duplexer2
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/readable-stream
"
