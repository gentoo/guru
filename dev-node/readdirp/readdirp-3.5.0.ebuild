# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Recursive version of fs.readdir with streaming API."
HOMEPAGE="
	https://github.com/paulmillr/readdirp
	https://www.npmjs.com/package/readdirp
"
SRC_URI="https://registry.npmjs.org/readdirp/-/readdirp-3.5.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/picomatch
"
