# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517="pdm-backend"
PYTHON_COMPAT=( python3_10 python3_11 python3_12 )
inherit distutils-r1

DESCRIPTION="The client library for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/b2-sdk-python"
SRC_URI="https://github.com/Backblaze/b2-sdk-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/b2-sdk-python-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

export PDM_BUILD_SCM_VERSION=${PV}

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/logfury-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
		>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
	')
"

distutils_enable_tests pytest

# tqdm dependency is temporary, see
# https://github.com/Backblaze/b2-sdk-python/issues/489
BDEPEND+=" test? (
	$(python_gen_cond_dep '
		>=dev-python/pytest-mock-3.6.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-lazy-fixture-0.6.3[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.66.2[${PYTHON_USEDEP}]
	')
)"

# These tests seem to require some b2 authentication (they're integration tests
# so this is not unreasonable)
python_test() {
	# note: used to avoid an ExcessiveLineLength lint below.
	local sqlite_test_path="test/unit/account_info/test_sqlite_account_info.py"

	# https://github.com/Backblaze/b2-sdk-python/issues/488
	epytest \
		--deselect test/integration/test_large_files.py::TestLargeFile::test_large_file \
		--deselect test/integration/test_raw_api.py::test_raw_api \
		--deselect test/integration/test_download.py::TestDownload::test_large_file \
		--deselect test/integration/test_download.py::TestDownload::test_small \
		--deselect test/integration/test_download.py::TestDownload::test_small_unverified \
		--deselect test/integration/test_download.py::TestDownload::test_gzip \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_invalid_profile_name \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_profile_and_file_name_conflict \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_profile_and_env_var_conflict \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_profile_and_xdg_config_env_var \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_profile \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_file_name \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_env_var \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_default_file_if_exists \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_xdg_config_env_var \
		--deselect ${sqlite_test_path}::TestSqliteAccountProfileFileLocation::test_default_file \
		--deselect test/unit/b2http/test_b2http.py::TestSetLocaleContextManager::test_set_locale_context_manager \
		test/unit
}
