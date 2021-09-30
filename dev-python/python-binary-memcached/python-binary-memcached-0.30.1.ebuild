# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="access memcached via it's binary protocol with SASL auth support"
HOMEPAGE="
	https://github.com/jaysonsantos/python-binary-memcached
	https://pypi.org/project/python-binary-memcached
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/uhashring[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-3.9[${PYTHON_USEDEP}]
		>=dev-python/trustme-0.6.0[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
