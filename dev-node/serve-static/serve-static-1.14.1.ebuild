# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Serve static files"
HOMEPAGE="
	https://github.com/expressjs/serve-static
	https://www.npmjs.com/package/serve-static
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/encodeurl
	dev-node/escape-html
	dev-node/parseurl
	dev-node/send
"
