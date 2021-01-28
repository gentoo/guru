# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Concatenate a readable stream's data into a single array"
HOMEPAGE="
	https://github.com/stream-utils/stream-to-array
	https://www.npmjs.com/package/stream-to-array
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/any-promise
"
