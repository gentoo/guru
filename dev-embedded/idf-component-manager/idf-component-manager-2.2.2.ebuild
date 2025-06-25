# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
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
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

# Requires networking or additional files not available in the tarball
EPYTEST_DESELECT=(
	tests/core/test_upload_component.py::test_check_only_upload_component
	tests/test_component_manager.py::test_pack_component_with_examples_errors
	tests/test_component_manager.py::test_pack_component_with_dest_dir
	tests/test_profile.py::TestMultiStorageClient::test_registry_storage_url
	tests/test_profile.py::TestMultiStorageClient::test_storage_clients_precedence
	tests/test_mirror_sync.py::test_sync_dependency_with_matches
	tests/test_mirror_sync.py::test_sync_dependency_with_rules
	tests/test_mirror_sync.py::test_update_existing_local_mirror
	tests/test_mirror_sync.py::test_registry_sync_latest_with_two_requirements
	tests/cli/test_manifest_command.py::test_add_git_dependency
	tests/cli/test_manifest_command.py::test_add_git_dependency_invalid
	tests/cli/test_manifest_command.py::test_manifest_keeps_comments
	tests/cli/test_module.py::test_raise_exception_on_warnings
	tests/cli/test_registry_command.py::test_logout_from_registry_revoked_token
	tests/sources/test_git.py::test_versions_component_hash
)

# network access
EPYTEST_IGNORE=(
	tests/test_api_client.py
	tests/test_prepare_dep_dirs.py
)

distutils_enable_tests pytest
