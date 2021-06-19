# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Cubic-to-quadratic bezier curve conversion"
HOMEPAGE="https://github.com/googlefonts/cu2qu"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
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
	dev-python/fs[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
