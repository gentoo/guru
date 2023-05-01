# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN=${PN#sphinxcontrib-}
DESCRIPTION="A Sphinx builder/writer to output reStructuredText (rst) files"
HOMEPAGE="
	https://pypi.org/project/sphinxcontrib-restbuilder/
	https://github.com/sphinx-contrib/restbuilder
"
SRC_URI="https://github.com/sphinx-contrib/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}

python_test() {
	rm -rf sphinxcontrib || die
	distutils_write_namespace sphinxcontrib
	epytest
}
