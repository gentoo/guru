# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="Helps to keep your local git repositories organized"
HOMEPAGE="https://gitlab.com/3point2/git-cu"

# This package has tests, but they are not included in the PyPi
# distribution.
RESTRICT="test"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
