# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1

DESCRIPTION="Sphinx extension to show tooltips with content embedded when hover a reference"
HOMEPAGE="
	https://pypi.org/project/sphinx-hoverxref/
	https://github.com/readthedocs/sphinx-hoverxref
"
SRC_URI="https://github.com/readthedocs/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-jquery[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/sphinxcontrib-bibtex[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# tests that require network
	tests/test_htmltag.py::test_intersphinx_default_configs
	tests/test_htmltag.py::test_intersphinx_python_mapping
	tests/test_htmltag.py::test_intersphinx_all_mappings
)

distutils_enable_tests pytest

# Bug #883189
#distutils_enable_sphinx docs \
#	dev-python/sphinx-autoapi \
#	dev-python/sphinx-notfound-page \
#	dev-python/sphinx-prompt \
#	dev-python/sphinx-tabs \
#	dev-python/sphinx-version-warning \
#	dev-python/sphinx-rtd-theme \
#	dev-python/sphinxcontrib-bibtex \
#	dev-python/sphinxemoji
