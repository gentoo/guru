# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Returns `true` if the given string looks like a glob pattern or an extglob pattern. This makes it easy to create code that only uses external modules like node-glob when necessary, resulting in much faster code execution and initialization time, and a bet"
HOMEPAGE="
	https://github.com/micromatch/is-glob
	https://www.npmjs.com/package/is-glob
"
SRC_URI="https://registry.npmjs.org/is-glob/-/is-glob-4.0.1.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/is-extglob
"
