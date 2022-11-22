# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_AUTODOC=1
DOCS_DEPEND="dev-python/mkdocs-material"

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit databases distutils-r1 docs optfeature

DESCRIPTION="Async database support for Python"
HOMEPAGE="
	https://www.encode.io/databases/
	https://github.com/encode/databases
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="<=dev-python/sqlalchemy-1.4.41[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/aiomysql[${PYTHON_USEDEP}]
	dev-python/aiopg[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/async-timeout[${PYTHON_USEDEP}]
	dev-python/asyncmy[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[sqlite,${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# fix tests
	#sed -i -e '/databases.backends.mysql/d' tests/test_connection_options.py || die

	distutils-r1_python_prepare_all
}

src_test() {
	local databases=(
		"sqlite:///testsuite"
		"sqlite+aiosqlite:///testsuite"
		"mysql://root@127.0.0.1:3333/testsuite"
		"mysql+aiomysql://root@127.0.0.1:3333/testsuite"
		"mysql+asyncmy://root@127.0.0.1:3333/testsuite"
		"postgresql://postgres@127.0.0.1:65432/"
		"postgresql+aiopg://postgres@127.0.0.1:65432/"
		"postgresql+asyncpg://postgres@127.0.0.1:65432/"
	)

	local -x TEST_DATABASE_URLS=$(printf "%s," "${databases[@]}")
	TEST_DATABASE_URLS=${TEST_DATABASE_URLS::-1}

	emysql --start 3333
	epostgres --start 65432

	ebegin "Creating mysql database 'testsuite'"
	mysql --user=root --socket=$(emysql --get-sockfile) --silent \
		--execute="CREATE DATABASE testsuite;"
	eend $? || emysql --die "Creating mysql database failed"

	distutils-r1_src_test

	emysql --stop
	epostgres--stop
}

pkg_postinst() {
	optfeature "fancy logs" dev-python/click
	optfeature "mysql support" dev-python/pymysql
	optfeature "mysql+aiomysql support" dev-python/aiomysql
	optfeature "mysql+asyncmy support" dev-python/asyncmy
	optfeature "postgresql support" dev-python/psycopg:2
	optfeature "postgresql+asyncpg support" dev-python/asyncpg
	optfeature "postgresql+aiopg support" dev-python/aiopg
	optfeature "sqlite+aiosqlite support" dev-python/aiosqlite
}
