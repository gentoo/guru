# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A comprehensive, fast, pure-Python memcached client"
HOMEPAGE="
	https://github.com/pinterest/pymemcache
	https://pypi.org/project/pymemcache
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-python/six[${PYTHON_USEDEP}]
	test? (
		dev-python/future[${PYTHON_USEDEP}]
		dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/pylibmc[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
