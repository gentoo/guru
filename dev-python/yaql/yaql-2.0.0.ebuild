# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="YAQL: Yet Another Query Language"
HOMEPAGE="
	https://github.com/openstack/yaql
	https://pypi.org/project/yaql/
	https://launchpad.net/yaql
	https://opendev.org/openstack/yaql
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.8[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.4.2[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/fixtures-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]

	)
"

distutils_enable_tests pytest
