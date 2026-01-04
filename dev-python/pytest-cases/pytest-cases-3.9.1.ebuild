# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools

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
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( ${PN} pytest-asyncio pytest-harvest pytest-steps pytest-xdist )

distutils_enable_tests pytest

python_compile_all() {
	docs_compile
}
