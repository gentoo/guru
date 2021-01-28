# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="tar-stream is a streaming tar parser and generator and nothing else. It is streams2 and operates purely using streams which means you can easily extract/parse tarballs without ever hitting the file system."
HOMEPAGE="
	https://github.com/mafintosh/tar-stream
	https://www.npmjs.com/package/tar-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/bl
	dev-node/end-of-stream
	dev-node/fs-constants
	dev-node/inherits
	dev-node/readable-stream
"
