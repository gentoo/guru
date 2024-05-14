# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} ) #py3.13 doesn't compile

inherit databases distutils-r1 optfeature pypi

DESCRIPTION="Python ODBC library"
HOMEPAGE="
	https://pypi.org/project/pyodbc/
	https://github.com/mkleehammer/pyodbc
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mssql"

RDEPEND=">=dev-db/unixODBC-2.3.0"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		${DATABASES_DEPEND[mysql]}
		dev-db/myodbc:8.0
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Broken test, generates a string longer than 4000 characters
	tests/mysql_test.py::test_varchar
)

EPYTEST_IGNORE=(
	# No easy way to run an SqlServer during tests
	tests/sqlserver_test.py
)

python_test() {
	export PYODBC_MYSQL="DRIVER=/usr/$(get_libdir)/myodbc-8.0/libmyodbc8a.so;SERVER=localhost;PORT=44444;DATABASE=test"
	export PYODBC_POSTGRESQL="DRIVER=/usr/$(get_libdir)/psqlodbcw.so;SERVER=localhost;PORT=44445;DATABASE=test;UID=postgres"
	epytest
}

src_test() {
	emysql --start 44444
	epostgres --start 44445
	psql -U postgres -h 127.0.0.1 -p 44445 <<EOF
CREATE DATABASE test OWNER postgres
EOF
	distutils-r1_src_test
	epostgres --stop
	emysql --stop
}

pkg_postinst() {
	optfeature "MySQL support" dev-db/myodbc
	optfeature "PostgreSQL support" dev-db/psqlodbc
}
