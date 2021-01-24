# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Strip comments from JSON. Lets you use comments in your JSON files!"
HOMEPAGE="
	https://github.com/sindresorhus/strip-json-comments
	https://www.npmjs.com/package/strip-json-comments
"
SRC_URI="https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-3.1.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
