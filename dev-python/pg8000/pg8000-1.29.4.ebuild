# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
declare -A DATABASES_REQ_USE=( [postgres]="xml" )

inherit databases distutils-r1 edo pypi

DESCRIPTION="PostgreSQL interface library"
HOMEPAGE="
	https://github.com/tlocke/pg8000
	https://pypi.org/project/pg8000/
"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/scramp-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/versioningit[${PYTHON_USEDEP}]
	test? (
		${DATABASES_DEPEND[postgres]}
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

SSL_TESTS=(
	test/dbapi/auth/test_md5_ssl.py
	test/dbapi/auth/test_scram-sha-256_ssl.p
	test/legacy/auth/test_md5_ssl.py
	test/legacy/auth/test_scram-sha-256_ssl.py
	test/native/auth/test_md5_ssl.py
	test/native/auth/test_scram-sha-256_ssl.py
)

EPYTEST_DESELECT=(
	# TODO: ssl tests (need certificates and stuff)
	"${SSL_TESTS[@]}"

	# "could not determine data type of parameter $1" and other errors
	test/test_readme.py

	# "database doesn't exist" errors
	test/dbapi/auth/test_gss.py
	test/legacy/auth/test_gss.py
	test/native/auth/test_gss.py

	# too flaky
	test/native/test_typeconversion.py::test_roundtrip_oid
)

EPYTEST_IGNORE=(
	# need pytest-benchmark
	test/dbapi/test_benchmarks.py
	test/legacy/test_benchmarks.py
	test/native/test_benchmarks.py
)

distutils_enable_tests pytest

python_test_ssl() {
	epytest "${SSL_TESTS[@]}"
}

src_test() {
	epsql() {
		edo psql -q -h "${sockdir}" -U postgres "${@}"
	}

	local -x PGPORT="65432"
	local -x PGPASSWORD="cpsnow"
	local sockdir=$(epostgres --get-sockdir)

	epostgres --start ${PGPORT}
	epsql -c "ALTER ROLE postgres WITH PASSWORD '${PGPASSWORD}';"
	epsql -c "CREATE EXTENSION hstore;"
	epsql -c "SELECT pg_reload_conf();"

	distutils-r1_src_test
	epostgres --stop
}
