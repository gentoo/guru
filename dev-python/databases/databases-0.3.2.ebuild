# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

DOCBUILDER="mkdocs"
DOCDEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs optfeature

DESCRIPTION="Async database support for Python."
HOMEPAGE="
	https://www.encode.io/databases/
	https://github.com/encode/databases
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

# Requires 'TEST_DATABASE_URLS' to be set
# but to what, there is no documentation on this
# besides this looks like it requires internet so it will fail anyway
# To fix this, the whole 'TEST_DATABASE_URLS' stuff should probably be commented out
# or we download whatever 'TEST_DATABASE_URLS' is supposed to point at and the variable
# to that local directory
RESTRICT="test"

RDEPEND=">=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]"

# autoflake, codecov also required for tests?
DEPEND="test? (
	dev-python/aiomysql[${PYTHON_USEDEP}]
	dev-python/aiopg[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/psycopg[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

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
