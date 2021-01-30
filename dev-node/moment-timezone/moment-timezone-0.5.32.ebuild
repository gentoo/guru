# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parse and display moments in any timezone."
HOMEPAGE="
	http://momentjs.com/timezone/
	https://www.npmjs.com/package/moment-timezone
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/moment
"
