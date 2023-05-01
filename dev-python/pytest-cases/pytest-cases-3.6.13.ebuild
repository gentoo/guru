# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs

DESCRIPTION="Separate test code from test cases in pytest"
HOMEPAGE="https://pypi.org/project/pytest-cases/ https://github.com/smarie/python-pytest-cases"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/decopatch[${PYTHON_USEDEP}]
	>=dev-python/makefun-1.9.5[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-harvest[${PYTHON_USEDEP}]
		dev-python/pytest-steps[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	tests/pytest_extension/doc/test_doc_fixture_graph_union.py::test_closure
	tests/pytest_extension/fixtures/fixture_unions/test_fixture_closure_edits.py::test_super_closure_edits2
	tests/pytest_extension/fixtures/fixture_unions/test_fixtures_union_2hard.py::test_super_closure
)

distutils_enable_tests pytest

python_prepare_all() {
	sed "/pytest-runner/d" -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}
