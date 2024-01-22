# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# No pypy3 support: https://github.com/mkleehammer/pyodbc/issues/915
PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit databases edo distutils-r1 optfeature pypi

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

python_test() {
	edo ${EPYTHON} tests3/run_tests.py -vv \
		--mysql "DRIVER=/usr/$(get_libdir)/myodbc-8.0/libmyodbc8a.so;SERVER=localhost;PORT=44444;DATABASE=test"
}

src_test() {
	emysql --start 44444
	distutils-r1_src_test
	emysql --stop
}

src_install() {
	distutils-r1_src_install
	rm "${D}/usr/pyodbc.pyi" || die
}

pkg_postinst() {
	optfeature "MS SQL Server support" dev-db/freetds-0.64[odbc]
	optfeature "MySQL support" dev-db/myodbc
	optfeature "PostgreSQL support" dev-db/psqlodbc
}
