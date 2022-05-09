# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Library centralizing the most common distributed primitives"
HOMEPAGE="
	https://opendev.org/openstack/tooz
	https://pypi.org/project/tooz/
	https://launchpad.net/python-tooz
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/voluptuous-0.8.9[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.7[${PYTHON_USEDEP}]
	>=dev-python/tenacity-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-0.10.0[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.2.1[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.7[${PYTHON_USEDEP}]

		dev-python/etcd3[${PYTHON_USEDEP}]
		dev-python/etcd3gw[${PYTHON_USEDEP}]
		dev-python/pymemcache[${PYTHON_USEDEP}]
		dev-python/pymysql[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sysv_ipc[${PYTHON_USEDEP}]
		dev-python/zake[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose

python_prepare_all() {
	# allow usage of renamed msgpack
	sed -i '/^msgpack/d' requirements.txt || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests \
		-e tooz.tests.test_coordination.TestAPI \
		-e tooz.tests.test_memcache.TestMemcacheDriverFailures.test_client_failure_join \
		-e tooz.tests.test_memcache.TestMemcacheDriverFailures.test_client_failure_leave \
		-e tooz.tests.test_partitioner \
		|| die
}
