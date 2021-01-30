# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="list things in node_modules that are bundledDependencies, or transitive dependencies thereof"
HOMEPAGE="
	https://github.com/npm/npm-bundled
	https://www.npmjs.com/package/npm-bundled
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/npm-normalize-package-bin
"
