# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Determine if a value is an ES6 Symbol or not."
HOMEPAGE="
	https://github.com/inspect-js/is-symbol
	https://www.npmjs.com/package/is-symbol
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/has-symbols
"
