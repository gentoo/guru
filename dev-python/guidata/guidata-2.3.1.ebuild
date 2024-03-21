# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Library for user interfaces for easy dataset editing and display"
HOMEPAGE="https://pypi.python.org/pypi/guidata"
LICENSE="CeCILL-2"

SLOT="0"

# No automated tests can be performed afaik
RESTRICT="test"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP}]
"


KEYWORDS="~amd64 ~x86"
