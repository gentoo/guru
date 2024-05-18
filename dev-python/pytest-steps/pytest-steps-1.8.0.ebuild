# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs pypi

DESCRIPTION="Create step-wise / incremental tests in pytest"
HOMEPAGE="https://pypi.org/project/pytest-steps/ https://github.com/smarie/python-pytest-steps"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/makefun-1.5[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]
"
# https://github.com/smarie/python-pytest-cases/issues/330
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		<dev-python/pytest-8[${PYTHON_USEDEP}]
		dev-python/pytest-cases[${PYTHON_USEDEP}]
		dev-python/pytest-harvest[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-strict-mkdocs.patch" )

EPYTEST_DESELECT=(
	# tests fail with recent Pandas
	pytest_steps/tests/test_docs_example_with_harvest.py::test_synthesis_df
	pytest_steps/tests/test_steps_harvest.py::test_synthesis
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
	epytest pytest_steps/tests --doctest-modules
}
