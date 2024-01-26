# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

DOCS_BUILDER="mkdocs"
DOCS_DEPEND=(
	dev-python/mkdocs-material
	dev-python/regex
)

inherit distutils-r1 docs pypi

DESCRIPTION="Separate test code from test cases in pytest"
HOMEPAGE="
	https://pypi.org/project/pytest-cases/
	https://github.com/smarie/python-pytest-cases
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/decopatch[${PYTHON_USEDEP}]
	>=dev-python/makefun-1.15.1[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
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

distutils_enable_tests pytest

python_compile_all() {
	docs_compile
}
