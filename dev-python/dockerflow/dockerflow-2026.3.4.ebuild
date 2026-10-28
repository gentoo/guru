# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_TAG_NAME="$(printf '%4d.%02d.%02d' "$(ver_cut 1)" "$(ver_cut 2)" "$(ver_cut 3)")"

DESCRIPTION="Python tools and helpers for Mozilla's Dockerflow"
HOMEPAGE="
	https://github.com/mozilla-services/python-dockerflow
	https://pypi.org/project/dockerflow/
"
SRC_URI="https://github.com/mozilla-services/python-dockerflow/archive/${MY_TAG_NAME}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-dockerflow-${MY_TAG_NAME}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-db/redis
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/fakeredis[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/django-redis[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/asgiref[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/flask-login[${PYTHON_USEDEP}]
		dev-python/blinker[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{mock,cov,django} )
EPYTEST_IGNORE=(
	# sanic not packaged
	tests/sanic/test_sanic.py
	# flask-migrate not packaged
	tests/flask/test_flask.py
)
EPYTEST_DESELECT=(
	# I don't know what's going on with these
	tests/django/test_django.py::test_error_returns_500_and_logs_error
	tests/fastapi/test_fastapi.py::test_mozlog_without_correlation_id_middleware
	tests/fastapi/test_fastapi.py::test_error_returns_500_and_logs_error
)
distutils_enable_tests pytest

src_compile() {
	export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_DOCKERFLOW=${PV}
	distutils-r1_src_compile
}

python_test() {
	# Tests expect a running redis server, so let's provide it
	einfo 'starting Redis...'
	exec 3< <(redis-server /dev/null)
	local redis_pid=$!

	# Wait until it's ready
	while IFS= read -r line <&3 || die "failed to start redis server"; do
		echo "$line"
		[[ "$line" =~ "Ready to accept connections" ]] && break
	done
	cat <&3 &

	local -x DJANGO_SETTINGS_MODULE=tests.django.settings
	nonfatal epytest
	local epytest_result=$?

	einfo 'stopping Redis...'
	kill -INT $redis_pid
	wait $redis_pid

	(( epytest_result == 0 )) || die "pytest failed with ${EPYTHON}"
}
