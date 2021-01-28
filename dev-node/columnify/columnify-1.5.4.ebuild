# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Render data in text columns. Supports in-column text-wrap."
HOMEPAGE="
	https://github.com/timoxley/columnify
	https://www.npmjs.com/package/columnify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/strip-ansi
	dev-node/wcwidth
"
