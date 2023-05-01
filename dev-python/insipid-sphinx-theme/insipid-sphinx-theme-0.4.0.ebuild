# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..11} )
inherit distutils-r1

DESCRIPTION="An insipid Sphinx theme"
HOMEPAGE="
	https://pypi.org/project/insipid-sphinx-theme/
	https://github.com/mgeier/insipid-sphinx-theme
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/sphinx-5[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.18[${PYTHON_USEDEP}]
"

DOCS=( {CONTRIBUTING,NEWS,README}.rst )

# needs sphinx_last_updated_by_git
#distutils_enable_sphinx 'doc'
