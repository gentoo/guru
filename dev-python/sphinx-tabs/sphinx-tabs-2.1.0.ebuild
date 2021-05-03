# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Create tabbed content in Sphinx documentation when building HTML"
HOMEPAGE="https://github.com/executablebooks/sphinx-tabs https://pypi.org/project/sphinx-tabs/"
SRC_URI="https://github.com/executablebooks/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools_scm-1.15.0[${PYTHON_USEDEP}]
	test? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/path-py[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/sphinx-testing[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	# TODO: package https://pypi.org/project/rinohtype/
	epytest --deselect tests/test_build.py::test_rinohtype_pdf
}
