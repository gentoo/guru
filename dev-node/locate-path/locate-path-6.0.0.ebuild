# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Get the first path that exists on disk of multiple paths"
HOMEPAGE="
	https://github.com/sindresorhus/locate-path
	https://www.npmjs.com/package/locate-path
"
SRC_URI="https://registry.npmjs.org/locate-path/-/locate-path-6.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/p-locate
"
