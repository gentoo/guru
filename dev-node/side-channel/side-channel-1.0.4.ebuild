# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Store information about any JS value in a side channel. Uses WeakMap if available."
HOMEPAGE="
	https://github.com/ljharb/side-channel
	https://www.npmjs.com/package/side-channel
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/call-bind
	dev-node/get-intrinsic
	dev-node/object-inspect
"
