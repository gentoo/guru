# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="A comprehensive utility library to parse license expressions using boolean logic"
HOMEPAGE="
	https://pypi.org/project/license-expression/
	https://github.com/nexB/license-expression
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/boolean-py-4.0.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

distutils_enable_tests pytest

distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme
