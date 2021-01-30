# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="writable stream that concatenates strings or binary data and calls a callback with the result"
HOMEPAGE="
	https://github.com/maxogden/concat-stream
	https://www.npmjs.com/package/concat-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/buffer-from
	dev-node/inherits
	dev-node/readable-stream
	dev-node/typedarray
"
