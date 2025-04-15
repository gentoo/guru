# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

DOCS_BUILDER="mkdocs"
DOCS_DEPEND=(
	dev-python/mkdocs-material
	dev-python/regex
)
inherit distutils-r1 docs pypi

DESCRIPTION="Create decorators easily in python"
HOMEPAGE="https://pypi.org/project/decopatch/ https://github.com/smarie/python-decopatch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/makefun[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-cases[${PYTHON_USEDEP}] )
"

PATCHES=( "${FILESDIR}/${P}-python12.patch" )

EPYTEST_DESELECT=(
	# fails with whitespace differences in python 3.13
	tests/test_doc.py::test_doc_add_tag_function
)

distutils_enable_tests pytest

python_prepare_all() {
	sed "/pytest-runner/d" -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}
