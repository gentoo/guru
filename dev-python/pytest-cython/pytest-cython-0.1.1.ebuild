# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( pypy3 python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/lgpage/pytest-cython"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme
distutils_enable_tests pytest

python_test() {
	epytest -vv \
		--deselect tests/test_pytest_cython.py::test_wrap_c_ext_module \
		--deselect tests/test_pytest_cython.py::test_cython_ext_module \
		--deselect tests/test_pytest_cython.py::test_wrap_cpp_ext_module \
		--deselect tests/test_pytest_cython.py::test_pure_py_module \
		|| die
}
