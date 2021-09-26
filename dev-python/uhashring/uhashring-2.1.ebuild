# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Full featured consistent hashing python library compatible with ketama"
HOMEPAGE="https://github.com/ultrabug/uhashring"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/python-memcached-1.59[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
