# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	os_api_ref/tests/test_basic_example.py::TestBasicExample::test_parameters
	os_api_ref/tests/test_basic_example.py::TestBasicExample::test_rest_response
	os_api_ref/tests/test_microversions.py::TestMicroversions::test_parameters_table
	os_api_ref/tests/test_warnings.py::TestWarnings::test_missing_field
)
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
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
		dev-python/fixtures[${PYTHON_USEDEP}]
		>=dev-python/sphinx-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-python-3.12.patch"
	"${FILESDIR}/${P}-sphinx-7.2.0.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx doc/source ">=dev-python/openstackdocstheme-2.2.1"
