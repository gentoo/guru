# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
DESCRIPTION="An AtomicLong type using CFFI."
HOMEPAGE="https://github.com/dreid/atomiclong"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/python-cffi[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
