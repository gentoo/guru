# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1

DESCRIPTION="Efficient 2D plotting Python library based on PythonQwt "
HOMEPAGE="https://pypi.python.org/pypi/guiqwt"
SRC_URI="https://github.com/PlotPyStack/guiqwt/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/guidata[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/PythonQwt[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
