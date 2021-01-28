# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Ensure a function is only called once"
HOMEPAGE="
	https://github.com/sindresorhus/onetime
	https://www.npmjs.com/package/onetime
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mimic-fn
"
