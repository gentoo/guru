# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="tar-stream is a streaming tar parser and generator and nothing else"
HOMEPAGE="
	https://github.com/mafintosh/tar-stream
	https://www.npmjs.com/package/tar-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bl
	dev-js/end-of-stream
	dev-js/fs-constants
	dev-js/inherits
	dev-js/readable-stream
"
