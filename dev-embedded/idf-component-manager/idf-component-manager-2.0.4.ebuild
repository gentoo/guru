# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Tool for installing ESP-IDF components"
HOMEPAGE="https://github.com/espressif/idf-component-manager"
SRC_URI="https://github.com/espressif/${PN}/archive/refs/tags/v${PV}.tar.gz	-> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
		dev-python/filelock[${PYTHON_USEDEP}]
		dev-vcs/git
	)
"

RDEPEND="
	dev-python/cachecontrol[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jsonref[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pydantic-settings[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

# Requires additional files not available in the tarball
EPYTEST_DESELECT=(
	tests/test_component_manager.py::test_pack_component_with_examples_errors
	tests/test_component_manager.py::test_pack_component_with_dest_dir
	tests/test_profile.py::TestMultiStorageClient::test_registry_storage_url
	tests/test_profile.py::TestMultiStorageClient::test_storage_clients_precedence
)

# network access
EPYTEST_IGNORE=(
	tests/test_api_client.py
	tests/test_prepare_dep_dirs.py
)

distutils_enable_tests pytest
