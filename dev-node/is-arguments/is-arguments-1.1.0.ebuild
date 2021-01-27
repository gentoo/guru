# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Is this an arguments object? It's a harder question than you think."
HOMEPAGE="
	https://github.com/inspect-js/is-arguments
	https://www.npmjs.com/package/is-arguments
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/call-bind
"
