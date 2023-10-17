# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Efficient 2D plotting Python library based on PythonQwt "
HOMEPAGE="https://pypi.python.org/pypi/guiqwt"
LICENSE="MIT"

SLOT="0"
RESTRICT="test"

RDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/guidata[${PYTHON_USEDEP}]
"

KEYWORDS="~amd64 ~x86"
