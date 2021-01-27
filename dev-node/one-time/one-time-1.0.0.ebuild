# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Run the supplied function exactly one time (once)"
HOMEPAGE="
	https://github.com/3rd-Eden/one-time
	https://www.npmjs.com/package/one-time
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fn_name
"