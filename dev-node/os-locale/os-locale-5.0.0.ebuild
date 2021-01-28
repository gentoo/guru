# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the system locale"
HOMEPAGE="
	https://github.com/sindresorhus/os-locale
	https://www.npmjs.com/package/os-locale
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/execa
	dev-node/lcid
	dev-node/mem
"
