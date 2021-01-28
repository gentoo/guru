# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Extremely fast utf8 only stream implementation"
HOMEPAGE="
	https://github.com/mcollina/sonic-boom
	https://www.npmjs.com/package/sonic-boom
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/atomic-sleep
	dev-node/flatstr
"
