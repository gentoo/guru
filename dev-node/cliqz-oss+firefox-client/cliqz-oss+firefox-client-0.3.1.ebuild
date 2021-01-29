# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Firefox remote debugging client"
HOMEPAGE="
	https://github.com/harthur/firefox-client
	https://www.npmjs.com/package/@cliqz-oss/firefox-client
"

PN_LEFT="${PN%%+*}"
PN_RIGHT="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${PN_LEFT}/${PN_RIGHT}/-/${PN_RIGHT}-${PV}.tgz -> ${P}.tgz"
KEYWORDS="~amd64"
#no license ... https://github.com/harthur/firefox-client/issues/17
LICENSE=""
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/colors
	dev-node/js-select
"
