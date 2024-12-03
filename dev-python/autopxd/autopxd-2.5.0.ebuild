# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )
PYPI_PN="${PN}2"
inherit distutils-r1 pypi

DESCRIPTION="generates .pxd files automatically from .h files"
HOMEPAGE="
	https://github.com/elijahr/python-autopxd2
	https://pypi.org/project/autopxd2
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EPYTEST_XDIST=1
distutils_enable_tests pytest

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
"

python_test() {
	epytest
}
