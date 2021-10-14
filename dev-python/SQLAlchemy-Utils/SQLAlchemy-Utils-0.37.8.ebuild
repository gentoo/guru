# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=( tests/types/test_timezone.py )
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Various utility functions and datatypes for SQLAlchemy"
HOMEPAGE="
	https://github.com/kvesteri/sqlalchemy-utils
	https://pypi.org/project/SQLAlchemy-Utils
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/pygments-2.7.1[${PYTHON_USEDEP}]
		>=dev-python/jinja-2.3[${PYTHON_USEDEP}]
		>=dev-python/docutils-0.10[${PYTHON_USEDEP}]
		>=dev-python/flexmock-0.9.7[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2.5.1[${PYTHON_USEDEP}]
		>=dev-python/psycopg2cffi-2.8.1[${PYTHON_USEDEP}]
		>=dev-python/pg8000-1.12.4[${PYTHON_USEDEP}]
		>=dev-python/pytz-2014.2[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.6[${PYTHON_USEDEP}]
		dev-python/pymysql[${PYTHON_USEDEP}]
		dev-python/pyodbc[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
