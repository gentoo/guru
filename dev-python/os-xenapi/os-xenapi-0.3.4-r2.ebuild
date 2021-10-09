# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	os_xenapi/tests/plugins/test_agent.py::AgentTestCase::test_inject_file_with_old_agent
	os_xenapi/tests/plugins/test_xenhost.py::NetworkTestCase::test_iptables_config
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="XenAPI library for OpenStack projects"
HOMEPAGE="
	https://github.com/openstack/os-xenapi
	https://launchpad.net/os-xenapi
	https://launchpad.net/os-xenapi
	https://opendev.org/x/os-xenapi
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.3.4[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-0.11.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/os-testr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/reno-2.5.0[${PYTHON_USEDEP}]

		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
