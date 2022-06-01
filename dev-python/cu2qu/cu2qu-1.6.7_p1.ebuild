# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
MYPV="${PV/_p/.post}"
MYP="${PN}-${MYPV}"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Cubic-to-quadratic bezier curve conversion"
HOMEPAGE="https://github.com/googlefonts/cu2qu"
SRC_URI="mirror://pypi/${MYP:0:1}/${PN}/${MYP}.zip"
S="${WORKDIR}/${MYP}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-3.32[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	export CU2QU_WITH_CYTHON=1
	distutils-r1_src_prepare
}
