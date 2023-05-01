# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Plugin for testing Cython extension modules"
HOMEPAGE="
	https://pypi.org/project/pytest-cython/
	https://github.com/lgpage/pytest-cython
"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/py[${PYTHON_USEDEP}]
	>=dev-python/pytest-4.6.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/cython[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/myst-parser \
	dev-python/sphinx-py3doc-enhanced-theme

python_test() {
	epytest tests
}
