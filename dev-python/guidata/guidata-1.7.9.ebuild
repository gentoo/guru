# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Library for user interfaces for easy dataset editing and display"
HOMEPAGE="https://pypi.python.org/pypi/guidata"
LICENSE="CeCILL-2"

SLOT="0"
IUSE=""

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP}]
"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
