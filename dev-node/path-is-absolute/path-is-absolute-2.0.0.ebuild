# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Node.js 0.12 path.isAbsolute() ponyfill"
HOMEPAGE="
	https://github.com/sindresorhus/path-is-absolute
	https://www.npmjs.com/package/path-is-absolute
"
SRC_URI="https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-2.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
