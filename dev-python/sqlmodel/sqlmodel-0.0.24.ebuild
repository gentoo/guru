# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="SQL databases in Python, designed for simplicity, compatibility, and robustness."
HOMEPAGE="
	https://sqlmodel.tiangolo.com/
	https://github.com/fastapi/sqlmodel/
	https://pypi.org/project/sqlmodel/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/sqlalchemy-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.14[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.13[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Uses coverage
	# TIP: Search for subprocess.run([coverage])
	"tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_py310_tests_main.py::test_run_tests"
	"tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_py39_tests_main.py::test_run_tests"
	"tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_tests_main.py::test_run_tests"
)

EPYTEST_IGNORE=(
	# Uses coverage
	# TIP: Search for imports of coverage_run
	"tests/test_tutorial/test_create_db_and_table/test_tutorial001.py"
	"tests/test_tutorial/test_create_db_and_table/test_tutorial001_py310.py"
)

python_test() {
	epytest tests
}
