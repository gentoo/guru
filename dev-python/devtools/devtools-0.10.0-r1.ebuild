# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

DOCS_BUILDER=mkdocs
DOCS_DEPEND=(
	dev-python/ansi2html
	dev-python/markdown-include
	dev-python/mkdocs-exclude
	dev-python/mkdocs-material
)

inherit distutils-r1 docs pypi

DESCRIPTION="Dev tools for python"
HOMEPAGE="
	https://pypi.org/project/devtools/
	https://github.com/samuelcolvin/python-devtools
"
RESTRICT="!test? ( test )"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/asttokens[${PYTHON_USEDEP}]
	dev-python/executing[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/multidict[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
