# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Check if something is a Node.js stream"
HOMEPAGE="
	https://github.com/sindresorhus/is-stream
	https://www.npmjs.com/package/is-stream
"
SRC_URI="https://registry.npmjs.org/is-stream/-/is-stream-2.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
