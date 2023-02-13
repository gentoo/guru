# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	osprofiler/tests/functional/test_driver.py::DriverTestCase::test_get_report
	osprofiler/tests/functional/test_driver.py::RedisDriverTestCase::test_get_report
	osprofiler/tests/functional/test_driver.py::RedisDriverTestCase::test_list_traces
	osprofiler/tests/unit/test_opts.py::ConfigTestCase::test_options_defaults
	osprofiler/tests/unit/test_profiler.py::ProfilerGlobMethodsTestCase::test_get_profiler_and_init
	osprofiler/tests/unit/test_profiler.py::test_fn_exc
)
EPYTEST_IGNORE=( osprofiler/tests/unit/drivers/test_jaeger.py )
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="OpenStack Profiler Library"
HOMEPAGE="
	https://launchpad.net/osprofiler
	https://opendev.org/openstack/osprofiler
	https://pypi.org/project/osprofiler/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/ddt-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/pymongo-3.0.2[${PYTHON_USEDEP}]
		>=dev-python/elasticsearch-py-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/redis-2.10.0[${PYTHON_USEDEP}]
		>=dev-python/reno-3.1.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
