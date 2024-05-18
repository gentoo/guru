# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python function signatures package for Python 2.6, 2.7 and 3.2+"
HOMEPAGE="https://github.com/aliles/funcsigs https://pypi.org/project/funcsigs"
SRC_URI="https://github.com/aliles/funcsigs/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
