# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="file change notification that doesn't suck hairy monkey balls and just works."
HOMEPAGE="
		https://www.npmjs.com/package/fs.notify
"

MYPN="${PN//_/.}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/async
	dev-node/retry
"
