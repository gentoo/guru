# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{8..11} )
inherit distutils-r1

MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Pytest plugin for Click"
HOMEPAGE="
	https://pypi.org/project/pytest-click/
	https://github.com/Stranger6667/pytest-click
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"

DOCS=( CHANGELOG.md README.rst )

distutils_enable_tests pytest
