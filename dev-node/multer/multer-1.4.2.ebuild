# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Middleware for handling multipart/form-data."
HOMEPAGE="
	https://github.com/expressjs/multer
	https://www.npmjs.com/package/multer
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/append-field
	dev-node/busboy
	dev-node/concat-stream
	dev-node/mkdirp
	dev-node/object-assign
	dev-node/on-finished
	dev-node/type-is
	dev-node/xtend
"
