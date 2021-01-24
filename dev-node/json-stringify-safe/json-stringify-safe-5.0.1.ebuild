# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Like JSON.stringify, but doesn't blow up on circular refs."
HOMEPAGE="
	https://github.com/isaacs/json-stringify-safe
	https://www.npmjs.com/package/json-stringify-safe
"
SRC_URI="https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
