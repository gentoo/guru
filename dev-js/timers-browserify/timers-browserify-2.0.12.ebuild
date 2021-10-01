# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="timers module for browserify"
HOMEPAGE="
	https://github.com/jryans/timers-browserify
	https://www.npmjs.com/package/timers-browserify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/setimmediate
"
