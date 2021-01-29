# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Port of C's wcwidth() and wcswidth()"
HOMEPAGE="
	https://github.com/timoxley/wcwidth
	https://www.npmjs.com/package/wcwidth
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/defaults
"
