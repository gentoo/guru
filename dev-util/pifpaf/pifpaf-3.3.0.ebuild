# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit click-app distutils-r1 pypi

DESCRIPTION="Suite of tools and fixtures to manage daemons for testing"
HOMEPAGE="
	https://pypi.org/project/pifpaf/
	https://github.com/jd/pifpaf
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/daiquiri[${PYTHON_USEDEP}]
	dev-python/fixtures[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		|| (
			dev-python/pyxattr[${PYTHON_USEDEP}]
			dev-python/xattr[${PYTHON_USEDEP}]
		)'
	)
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		app-admin/consul
		app-admin/vault
		dev-db/etcd[server]
		dev-db/postgresql[server]
		dev-db/redis
		dev-python/httpbin[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/testtools[${PYTHON_USEDEP}]
		net-misc/kafka-bin
		net-misc/memcached
		net-misc/rabbitmq-server
		sys-cluster/ceph
		virtual/mysql[server]
	)
"

EPYTEST_DESELECT=(
	# Drivers need fixes
	pifpaf/tests/test_drivers.py::TestDrivers::test_influxdb
	pifpaf/tests/test_drivers.py::TestDrivers::test_mongodb
	pifpaf/tests/test_drivers.py::TestDrivers::test_redis_sentinel
)

distutils_enable_tests pytest

click-app_enable_completions pifpaf

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	# RabbitMQ wrappers installed to /usr/sbin require to be run as root.
	local -x PATH="${BUILD_DIR}/install${EPREFIX}/usr/bin:${BROOT}/usr/libexec/rabbitmq:${PATH}"
	epytest
}
