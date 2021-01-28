# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Mapping between standard locale identifiers and Windows locale identifiers (LCID)"
HOMEPAGE="
	https://github.com/sindresorhus/lcid
	https://www.npmjs.com/package/lcid
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/invert-kv
"
