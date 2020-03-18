# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="aiopg is a library for accessing a PostgreSQL database from the asyncio"
HOMEPAGE="
    https://aiopg.readthedocs.io
    https://github.com/aio-libs/aiopg
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/psycopg[${PYTHON_USEDEP}]"

DEPEND="test? ( dev-python/coverage[${PYTHON_USEDEP}]
                dev-python/sphinx[${PYTHON_USEDEP}]
                dev-python/tox[${PYTHON_USEDEP}]
                dev-python/isort[${PYTHON_USEDEP}]
                dev-python/pytest-cov[${PYTHON_USEDEP}]
                dev-python/pytest-timeout[${PYTHON_USEDEP}]
                dev-python/sqlalchemy[${PYTHON_USEDEP}]
                dev-python/flake8[${PYTHON_USEDEP}]
                dev-python/sphinxcontrib-asyncio[${PYTHON_USEDEP}] )"

pkg_postinst() {
    optfeature "sqlalchemy support" dev-python/sqlalchemy
}

distutils_enable_tests pytest
