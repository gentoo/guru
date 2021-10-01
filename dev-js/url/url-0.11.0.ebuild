# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The core url packaged standalone for use with Browserify."
HOMEPAGE="
	https://github.com/defunctzombie/node-url
	https://www.npmjs.com/package/url
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/punycode
	dev-js/querystring
"
