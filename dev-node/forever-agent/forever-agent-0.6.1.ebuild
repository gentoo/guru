# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="HTTP Agent that keeps socket connections alive between keep-alive requests. Formerly part of mikeal/request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/forever-agent
	https://www.npmjs.com/package/forever-agent
"
SRC_URI="https://registry.npmjs.org/forever-agent/-/forever-agent-0.6.1.tgz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
