# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Create decorators easily in python"
HOMEPAGE="
	https://pypi.org/project/decopatch/
	https://github.com/smarie/python-decopatch
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/makefun[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${P}-python12.patch"
	"${FILESDIR}/${P}-pkg_resources.patch"
)

EPYTEST_PLUGINS=( pytest-cases )
EPYTEST_DESELECT=(
	# fails with whitespace differences in python 3.13
	tests/test_doc.py::test_doc_add_tag_function
)

distutils_enable_tests pytest

src_prepare() {
	sed "/pytest-runner/d" -i setup.cfg || die
	distutils-r1_src_prepare
}
