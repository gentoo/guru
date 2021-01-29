# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Implementation of JSON Merge Patch (RFC 7396)"
HOMEPAGE="
	https://github.com/pierreinglebert/json-merge-patch
	https://www.npmjs.com/package/json-merge-patch
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/deep-equal
"
