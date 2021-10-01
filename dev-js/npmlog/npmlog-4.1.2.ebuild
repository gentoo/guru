# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="logger for npm"
HOMEPAGE="
	https://github.com/npm/npmlog
	https://www.npmjs.com/package/npmlog
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/are-we-there-yet
	dev-js/console-control-strings
	dev-js/gauge
	dev-js/set-blocking
"
