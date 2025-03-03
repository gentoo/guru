# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pbr
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="OpenStackClient plugin for Placement service"
HOMEPAGE="
	https://opendev.org/openstack/osc-placement
	https://pypi.org/project/python-octaviaclient/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth1-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.37.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
	    >=dev-python/coverage-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/python-openstackclient-3.3.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-4.2.2[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Require the placement service to be packaged, too
	osc_placement/tests/functional/test_allocation.py
	osc_placement/tests/functional/test_allocation_candidate.py
	osc_placement/tests/functional/test_inventory.py
	osc_placement/tests/functional/test_resource_class.py
	osc_placement/tests/functional/test_resource_provider.py
	osc_placement/tests/functional/test_trait.py
	osc_placement/tests/functional/test_usage.py
	osc_placement/tests/functional/test_aggregate.py
	osc_placement/tests/functional/test_plugin.py
)

distutils_enable_tests pytest
