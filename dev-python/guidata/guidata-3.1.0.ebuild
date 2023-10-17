# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Library for user interfaces for easy dataset editing and display"
HOMEPAGE="https://pypi.python.org/pypi/guidata"
LICENSE="BSD"

SLOT="0"
IUSE=""

# No automated tests can be performed afaik
RESTRICT="test"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP}]
"

KEYWORDS="~amd64 ~x86"
