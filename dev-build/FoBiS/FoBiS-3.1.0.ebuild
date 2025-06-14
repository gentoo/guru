# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_PN="${PN}.py"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="FoBiS.py, a Fortran Building System for poor men"
HOMEPAGE="https://github.com/szaghi/FoBiS"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"
RESTRICT="mirror"

RDEPEND="
	graphviz? ( dev-python/graphviz[${PYTHON_USEDEP}] )
"
