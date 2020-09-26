# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

DESCRIPTION="A more Pythonic version of doxypy, a Doxygen filter for Python"
HOMEPAGE="https://github.com/Feneric/doxypypy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

RESTRICT="!test? ( test )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-python/zope-interface[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest
