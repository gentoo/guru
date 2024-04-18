# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="PlexAPI"
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the Plex API."
HOMEPAGE="
	https://pypi.org/project/plexapi/
	https://github.com/pkkid/python-plexapi
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# almost all tests requires a running server
RESTRICT="test"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
