# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_PN="${PN}.py"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="FoBiS.py, a Fortran Building System for poor men"
HOMEPAGE="https://github.com/szaghi/FoBiS"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

IUSE="graphviz"

RDEPEND="
	graphviz? ( dev-python/graphviz[${PYTHON_USEDEP}] )
"

# removing "import future" and "from past.utils import old_div" from python scripts
PATCHES=( "${FILESDIR}/${PN}-3.0.2-remove-import-future_olddiv.patch" )
