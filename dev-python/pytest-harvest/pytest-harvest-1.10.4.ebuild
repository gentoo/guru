# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs pypi

DESCRIPTION="Store and retrieve data created during your pytest tests execution"
HOMEPAGE="https://pypi.org/project/pytest-harvest/ https://github.com/smarie/python-pytest-harvest"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/decopatch[${PYTHON_USEDEP}]
	>=dev-python/makefun-1.5[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest-cases[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-strict-mkdocs.patch" )

EPYTEST_DESELECT=(
	"pytest_harvest/tests/test_all_raw_with_meta_check.py::test_run_all_tests[test_get_session_results.py]"
	"pytest_harvest/tests/test_all_raw_with_meta_check.py::test_run_all_tests[test_get_session_results_indirect_and_noparam.py]"
)

distutils_enable_tests pytest

python_prepare_all() {
	sed "/pytest-runner/d" -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}

python_test() {
	epytest pytest_harvest/tests --doctest-modules
}
