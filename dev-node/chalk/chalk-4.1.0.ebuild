# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Terminal string styling done right"
HOMEPAGE="
	https://github.com/chalk/chalk
	https://www.npmjs.com/package/chalk
"
SRC_URI="https://registry.npmjs.org/chalk/-/chalk-4.1.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/ansi-styles
"
