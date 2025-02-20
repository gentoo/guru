# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..12} )

DOCS_BUILDER=mkdocs
DOCS_DEPEND="
	dev-python/ansi2html
	dev-python/markdown-include
	dev-python/mkdocs-exclude
	dev-python/mkdocs-material
"

inherit distutils-r1 docs pypi

DESCRIPTION="Dev tools for python"
HOMEPAGE="
	https://pypi.org/project/devtools/
	https://github.com/samuelcolvin/python-devtools
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/asttokens[${PYTHON_USEDEP}]
	dev-python/executing[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
BDEPEND="
	doc? (
		dev-python/numpy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/multidict[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	# replace mkdocs-simple-hooks with built-in hooks
	"${FILESDIR}/${P}-mkdocs-hooks.patch"
)

EPYTEST_DESELECT=(
	# requires pytest-pretty
	tests/test_insert_assert.py::test_insert_assert
	tests/test_insert_assert.py::test_insert_assert_print
	tests/test_insert_assert.py::test_deep
	tests/test_insert_assert.py::test_enum
	# incompatible with dev-python/executing-2
	tests/test_expr_render.py::test_executing_failure
)

distutils_enable_tests pytest
