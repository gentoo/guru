# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="PyMeeus"
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of Jean Meeus astronomical routines"
HOMEPAGE="
	https://pypi.org/project/PyMeeus/
	https://github.com/architest/pymeeus
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

distutils_enable_sphinx docs/source \
	dev-python/sphinx-rtd-theme
