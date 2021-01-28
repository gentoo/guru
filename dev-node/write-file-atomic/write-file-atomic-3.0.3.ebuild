# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Write files in an atomic fashion w/configurable ownership"
HOMEPAGE="
	https://github.com/npm/write-file-atomic
	https://www.npmjs.com/package/write-file-atomic
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/imurmurhash
	dev-node/is-typedarray
	dev-node/signal-exit
	dev-node/typedarray-to-buffer
"
