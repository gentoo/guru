# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit databases distutils-r1 edo

DESCRIPTION="Implementation of the psycopg2 module using cffi. Compatible with Psycopg 2.5."
HOMEPAGE="
	https://pypi.org/project/psycopg2cffi/
	https://github.com/chtd/psycopg2cffi
"
SRC_URI="https://github.com/chtd/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-db/postgresql:="
RDEPEND="
	${DEPEND}
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
	test? ( ${DATABASES_DEPEND[postgres]} )
"

PATCHES=( "${FILESDIR}"/${P}-include-tests.patch )

EPYTEST_DESELECT=(
	# hang
	tests/psycopg2_tests/test_cancel.py::CancelTests::test_async_cancel
	# fail
	tests/psycopg2_tests/test_dates.py::FromTicksTestCase::test_date_value_error_sec_59_99
	tests/psycopg2_tests/test_types_basic.py::TypesBasicTests::testEmptyArray
)

distutils_enable_tests pytest

python_test() {
	cd "${T}" || die
	epytest --pyargs ${PN}
}

src_test() {
	local -x PSYCOPG2_TESTDB_HOST="localhost"
	local -x PSYCOPG2_TESTDB_PORT="55432"
	local -x PSYCOPG2_TESTDB_USER="postgres"
	epostgres --start ${PSYCOPG2_TESTDB_PORT}
	edo createdb -h ${PSYCOPG2_TESTDB_HOST} -p ${PSYCOPG2_TESTDB_PORT} -U postgres psycopg2_test

	distutils-r1_src_test
	epostgres --stop
}
