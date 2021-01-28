# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Relaxed JSON is strict superset JSON, relaxing strictness of valilla JSON"
HOMEPAGE="
	https://github.com/phadej/relaxed-json
	https://www.npmjs.com/package/relaxed-json
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/chalk
	dev-node/commander
"
