# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit distutils-r1

DESCRIPTION="aiomysql is a library for accessing a MySQL database from the asyncio"
HOMEPAGE="
    https://aiomysql.readthedocs.io/en/latest/
    https://github.com/aio-libs/aiomysql
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pymysql-0.9.0[${PYTHON_USEDEP}]"

DEPEND="test? ( dev-python/coverage[${PYTHON_USEDEP}]
                dev-python/flake8[${PYTHON_USEDEP}]
                dev-python/pytest-cov[${PYTHON_USEDEP}]
                dev-python/sphinx[${PYTHON_USEDEP}]
                dev-python/sphinxcontrib-asyncio[${PYTHON_USEDEP}]
                dev-python/sqlalchemy[${PYTHON_USEDEP}]
                dev-python/uvloop[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
