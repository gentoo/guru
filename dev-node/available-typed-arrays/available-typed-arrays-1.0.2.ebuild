# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Returns an array of Typed Array names that are available in the current environment"
HOMEPAGE="
	https://github.com/inspect-js/available-typed-arrays
	https://www.npmjs.com/package/available-typed-arrays
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/array-filter
"
