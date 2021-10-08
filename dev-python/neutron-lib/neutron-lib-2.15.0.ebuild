# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	neutron_lib/tests/unit/api/test_attributes.py::TestCoreResources::test_core_resource_attrs
	neutron_lib/tests/unit/objects/test_common_types.py::TestField::test_coerce_good_values
	neutron_lib/tests/unit/objects/test_common_types.py::TestField::test_coerce_bad_values
	neutron_lib/tests/unit/objects/test_common_types.py::TestField::test_to_primitive
	neutron_lib/tests/unit/objects/test_common_types.py::TestField::test_to_primitive_json_serializable
	neutron_lib/tests/unit/objects/test_common_types.py::TestField::test_from_primitive
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Neutron shared routines and utilities."
HOMEPAGE="
	https://github.com/openstack/neutron-lib
	https://opendev.org/openstack/neutron-lib
	https://pypi.org/project/neutron-lib

"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/sqlalchemy-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/pecan-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.14.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/os-ken-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-4.44.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.6.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.31.2[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/setproctitle-1.1.10[${PYTHON_USEDEP}]
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/os-traits-0.9.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/reno-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
