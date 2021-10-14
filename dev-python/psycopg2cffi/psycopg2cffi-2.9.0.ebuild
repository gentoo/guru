# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Implementation of the psycopg2 module using cffi. Compatible with Psycopg 2.5."
HOMEPAGE="
	https://github.com/chtd/psycopg2cffi
	https://pypi.org/project/psycopg2cffi
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/postgresql:*
	dev-python/six[${PYTHON_USEDEP}]
	virtual/python-cffi[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
