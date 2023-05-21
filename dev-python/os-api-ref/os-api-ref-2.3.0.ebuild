# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=( os_api_ref/tests/test_microversions.py::TestMicroversions::test_parameters_table )
PYTHON_COMPAT=( python3_10 )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Sphinx Extensions to support API reference sites in OpenStack"
HOMEPAGE="
	https://opendev.org/openstack/os-api-ref
	https://pypi.org/project/os-api-ref/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/openstackdocstheme-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/sphinx-4.0.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/beautifulsoup4-4.6.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-testing-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source ">=dev-python/openstackdocstheme-2.2.1"
