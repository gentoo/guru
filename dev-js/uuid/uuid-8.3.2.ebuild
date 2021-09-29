# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="RFC4122 (v1, v4, and v5) UUIDs"
HOMEPAGE="
	https://github.com/uuidjs/uuid
	https://www.npmjs.com/package/uuid
"

LICENSE="MIT"
KEYWORDS="~amd64"

src_install() {
	node_src_install
	# errno binary conflicts with dev-libs/ossp-uuid
	mv "${ED}/usr/bin/uuid" "${ED}/usr/bin/node-uuid" || die
}
