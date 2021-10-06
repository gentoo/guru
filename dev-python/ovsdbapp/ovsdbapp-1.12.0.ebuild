# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	ovsdbapp/tests/functional/backend/ovs_idl/test_backend.py
	ovsdbapp/tests/functional/backend/ovs_idl/test_connection.py
	ovsdbapp/tests/functional/backend/ovs_idl/test_indexing.py
	ovsdbapp/tests/functional/schema/open_vswitch/test_common_db.py
	ovsdbapp/tests/functional/schema/open_vswitch/test_impl_idl.py
	ovsdbapp/tests/functional/schema/ovn_northbound/test_impl_idl.py
	ovsdbapp/tests/functional/schema/ovn_southbound/test_impl_idl.py
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A library for creating OVSDB applications"
HOMEPAGE="
	https://opendev.org/openstack/ovsdbapp
	https://pypi.org/project/ovsdbapp
	https://launchpad.net/ovsdbapp
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/ovs-2.10.0[${PYTHON_USEDEP}]
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
