# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="OpenStack DNS-as-a-Service - Client"
HOMEPAGE="
	https://opendev.org/openstack/python-designateclient
	https://github.com/openstack/python-designateclient/
	https://pypi.org/project/python-designateclient/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/cliff-2.10.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.8.0[${PYTHON_USEDEP}]
	>dev-python/oslo-serialization-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>dev-python/pbr-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth1-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/stevedore-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.2.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		>=dev-python/coverage-4.5.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/tempest-25.0.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# not packaged
	designateclient/hacking/checks.py
)

distutils_enable_tests pytest
