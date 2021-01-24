# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="RFC4122 (v1, v4, and v5) UUIDs"
HOMEPAGE="
	https://github.com/uuidjs/uuid
	https://www.npmjs.com/package/uuid
"
SRC_URI="https://registry.npmjs.org/uuid/-/uuid-8.3.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
