# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A comprehensive, fast, pure-Python memcached client"
HOMEPAGE="
	https://github.com/pinterest/pymemcache
	https://pypi.org/project/pymemcache/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/future[${PYTHON_USEDEP}]
		>=dev-python/gevent-21.12.0[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		>=dev-python/pylibmc-1.6.1[${PYTHON_USEDEP}]
		>=dev-python/python-memcached-1.59[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-3.5.1-no-coverage.patch" )

distutils_enable_tests pytest
