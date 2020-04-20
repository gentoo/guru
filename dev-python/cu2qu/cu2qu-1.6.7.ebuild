# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"
KEYWORDS="~amd64"
DESCRIPTION="Cubic-to-quadratic bezier curve conversion"
HOMEPAGE="https://github.com/googlefonts/cu2qu"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-3.32[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
