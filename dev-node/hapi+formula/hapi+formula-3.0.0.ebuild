# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Math and string formula parser."
HOMEPAGE="
	https://github.com/hapijs/formula
	https://www.npmjs.com/package/@hapi/formula
"
SRC_URI="https://registry.npmjs.org/@hapi/formula/-/formula-3.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
