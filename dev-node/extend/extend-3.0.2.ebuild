# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Port of jQuery.extend for node.js and the browser"
HOMEPAGE="
	https://github.com/justmoon/node-extend
	https://www.npmjs.com/package/extend
"
SRC_URI="https://registry.npmjs.org/extend/-/extend-3.0.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
