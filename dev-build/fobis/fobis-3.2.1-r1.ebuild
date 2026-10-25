# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_PN="FoBiS.py"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="FoBiS.py, a Fortran Building System for poor men"
HOMEPAGE="
	https://szaghi.github.io/FoBiS/
	https://github.com/szaghi/FoBiS
	https://pypi.org/project/FoBiS.py/
"
SRC_URI="$(pypi_sdist_url "${PN}_py" "${PV}") -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"
RESTRICT="mirror"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		graphviz? ( dev-python/graphviz[${PYTHON_USEDEP}] )
	')
"
