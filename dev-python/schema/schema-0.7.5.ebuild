# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{8,9,10} )

inherit distutils-r1

DESCRIPTION="Python module to validate and convert data structures"
HOMEPAGE="https://github.com/keleshev/schema"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
