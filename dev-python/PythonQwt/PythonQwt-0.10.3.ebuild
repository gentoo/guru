# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Qt plotting widgets for Python "
HOMEPAGE="https://pypi.python.org/pypi/PythonQwt"
LICENSE="MIT"

SLOT="0"
RETRICT="test"

RDEPEND="dev-python/PyQt5[${PYTHON_USEDEP},svg]"

KEYWORDS="~amd64 ~x86"
