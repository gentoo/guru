# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit distutils-r1 eutils

DESCRIPTION="Async database support for Python."
HOMEPAGE="
    https://www.encode.io/databases/
    https://github.com/encode/databases
"
# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"  # 0.3.0 is missing for now so using github temporary
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]
         $(python_gen_cond_dep 'dev-python/aiocontextvars[${PYTHON_USEDEP}]' 'python3_6')"

# autoflake, codecov also required for tests?
DEPEND="test? ( dev-python/black[${PYTHON_USEDEP}]
                dev-python/isort[${PYTHON_USEDEP}]
                dev-python/mypy[${PYTHON_USEDEP}]
                dev-python/starlette[${PYTHON_USEDEP}]
                dev-python/pytest-cov[${PYTHON_USEDEP}]
                dev-python/requests[${PYTHON_USEDEP}] )"

python_prepare_all() {
    # do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

    distutils-r1_python_prepare_all
}

pkg_postinst() {
    optfeature "postgresql support" dev-python/asyncpg dev-python/psycopg
	optfeature "mysql support" dev-python/aiomysql dev-python/pymysql
	optfeature "sqlite support" dev-python/aiosqlite
    optfeature "postgresql+aiopg support" dev-python/aiopg
}

distutils_enable_tests pytest
