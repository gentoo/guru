# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# left here in case we switch to pypi
PYPI_PN="PlexAPI"
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12} )

inherit distutils-r1

DESCRIPTION="Python bindings for the Plex API."
HOMEPAGE="
	https://pypi.org/project/plexapi/
	https://github.com/pkkid/python-plexapi
"

# pypi release don't have docs
SRC_URI="https://github.com/pkkid/python-plexapi/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-${P}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# almost all tests requires a running server
RESTRICT="test"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"

BDEPEND="doc? ( dev-python/sphinx-rtd-theme )"

distutils_enable_sphinx docs
