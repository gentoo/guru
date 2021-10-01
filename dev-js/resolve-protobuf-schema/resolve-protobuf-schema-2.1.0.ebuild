# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Read a protobuf schema from the disk, parse it and resolve all imports"
HOMEPAGE="
	https://github.com/mafintosh/resolve-protobuf-schema
	https://www.npmjs.com/package/resolve-protobuf-schema
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/protocol-buffers-schema
"
