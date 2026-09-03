# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Read GCS, ABS and local paths with the same interface, tensorflow.io.gfile clone"
HOMEPAGE="
	https://github.com/blobfile/blobfile
	https://pypi.org/project/blobfile/
"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/filelock-3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.8[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2[${PYTHON_USEDEP}]
"
# numpy is imported but not declared in pyproject.toml
BDEPEND="
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/xmltodict[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all

	sed -e 's/pycryptodomex/pycryptodome/' -i pyproject.toml || die
	sed -e 's/from Cryptodome/from Crypto/' -i blobfile/_gcp.py || die

	# don't install tests
	# https://github.com/blobfile/blobfile/issues/226
	mkdir tests || die
	mv blobfile/*_test.py tests/ || die
}

python_test() {
	local EPYTEST_DESELECT=(
		# network
		tests/_ops_test.py::test_az_path
		tests/_ops_test.py::test_azure_public_get_url
		tests/_ops_test.py::test_copy_azure_public
		tests/_ops_test.py::test_gcs_public
		tests/_ops_test.py::test_concurrent_write_as
		tests/_ops_test.py::test_more_exists
		tests/_ops_test.py::test_invalid_paths
		tests/_ops_test.py::test_azure_public_container
		tests/_ops_test.py::test_scandir_error
	)

	epytest -k "not _get_temp_gcs_path and not _get_temp_as_path" tests
}
