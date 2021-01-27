# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Is this value a JS Boolean? This module works cross-realm/iframe, and despite ES6 @@toStringTag."
HOMEPAGE="
	https://github.com/ljharb/is-boolean-object
	https://www.npmjs.com/package/is-boolean-object
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/call-bind
"
