# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN=pyGeoTile
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Python package to handle tiles and points of different projections."
HOMEPAGE="https://github.com/geometalab/pyGeoTile"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
