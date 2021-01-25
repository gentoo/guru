# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Add callbacks to requests in flight to avoid async duplication"
HOMEPAGE="
	https://github.com/isaacs/inflight
	https://www.npmjs.com/package/inflight
"
SRC_URI="https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/once
	dev-node/wrappy
"
