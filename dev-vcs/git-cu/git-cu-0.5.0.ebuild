# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Helps to keep your local git repositories organized"
HOMEPAGE="https://gitlab.com/3point2/git-cu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

# This package has tests, but they are not included in the PyPi
# distribution.
RESTRICT="test"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
