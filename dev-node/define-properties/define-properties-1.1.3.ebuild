# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Define multiple non-enumerable properties at once. Uses Object.defineProperty when available; falls back to standard assignment in older engines."
HOMEPAGE="
	https://github.com/ljharb/define-properties
	https://www.npmjs.com/package/define-properties
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/object-keys
"
