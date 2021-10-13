# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Magnum API"
HOMEPAGE="
	https://github.com/openstack/python-magnumclient
	https://opendev.org/openstack/python-magnumclient
	https://launchpad.net/python-magnumclient
	https://pypi.org/project/python-magnumclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.3.4[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/os-client-config-1.28.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.0[${PYTHON_USEDEP}]
	>=dev-python/decorator-3.4.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-openstackclient-3.12.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
