# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Object.prototype.hasOwnProperty.call shortcut"
HOMEPAGE="
	https://github.com/tarruda/has
	https://www.npmjs.com/package/has
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/function-bind
"
