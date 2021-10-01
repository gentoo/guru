# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="filesystem bindings for tar-stream"
HOMEPAGE="
	https://github.com/mafintosh/tar-fs
	https://www.npmjs.com/package/tar-fs
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/chownr
	dev-js/mkdirp-classic
	dev-js/pump
	dev-js/tar-stream
"
