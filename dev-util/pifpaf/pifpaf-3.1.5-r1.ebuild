# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Suite of tools and fixtures to manage daemons for testing"
HOMEPAGE="
	https://pypi.org/project/pifpaf/
	https://github.com/jd/pifpaf
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# dev-python/pbr: for pbr.version
# dev-python/setuptools: for pkg_resources and distutils
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/daiquiri[${PYTHON_USEDEP}]
	dev-python/fixtures[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/xattr[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/pbr[${PYTHON_USEDEP}]
	test? (
		app-admin/consul
		app-admin/vault
		dev-db/postgresql[server]
		dev-db/redis
		dev-python/httpbin[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/testtools[${PYTHON_USEDEP}]
		net-misc/kafka-bin
		net-misc/memcached
		sys-cluster/ceph
		virtual/mysql[server]
	)
"

EPYTEST_DESELECT=(
	# Need updates to new CLIs and APIs
	pifpaf/tests/test_drivers.py::TestDrivers::test_etcd
	pifpaf/tests/test_drivers.py::TestDrivers::test_influxdb
	pifpaf/tests/test_drivers.py::TestDrivers::test_mongodb
	pifpaf/tests/test_drivers.py::TestDrivers::test_rabbitmq
	pifpaf/tests/test_drivers.py::TestDrivers::test_rabbitmq_cluster
	pifpaf/tests/test_drivers.py::TestDrivers::test_redis_sentinel
)

distutils_enable_tests pytest
