# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Vitrage API"
HOMEPAGE="
	https://github.com/openstack/python-vitrageclient
	https://opendev.org/openstack/python-vitrageclient
	https://launchpad.net/python-vitrageclient
	https://pypi.org/project/python-vitrageclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/cliff-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.11[${PYTHON_USEDEP}]
	>=dev-python/networkx-2.3[${PYTHON_USEDEP}]
	>=dev-python/pydot-1.4.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.3.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
