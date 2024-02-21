# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	jsonpath_rw_ext/tests/test_jsonpath_rw_ext.py::TestJsonpath_rw_ext::test_fields_value
	jsonpath_rw_ext/tests/test_jsonpath_rw_ext.py::TestJsonpath_rw_ext::test_shortcut_functions
)
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Extensions for JSONPath RW"
HOMEPAGE="
	https://pypi.org/project/jsonpath-rw-ext/
	https://github.com/sileht/python-jsonpath-rw-ext
"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.8[${PYTHON_USEDEP}]
	>=dev-python/jsonpath-rw-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
