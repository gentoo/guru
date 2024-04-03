# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_10 python3_11 python3_12 )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Command-line tool for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/B2_Command_Line_Tool"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-2.5.0-nameclash.patch"
	"${FILESDIR}/${PN}-3.9.0-disable-pip-requirement-installs.patch"
)

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/argcomplete-2.1.2[${PYTHON_USEDEP}]
		>=dev-python/arrow-1.0.2[${PYTHON_USEDEP}]
		>=dev-python/b2sdk-1.21.0[${PYTHON_USEDEP}]
		>=dev-python/docutils-0.19[${PYTHON_USEDEP}]
		>=dev-python/phx-class-registry-4.0.6[${PYTHON_USEDEP}]
		>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/rst2ansi-0.1.5[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.65.0[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		>=dev-python/importlib_metadata-3.3.0[${PYTHON_USEDEP}]
		' pypy3 python3_8)
"

DEPEND="
	test? (
		$(python_gen_cond_dep '
			>=dev-python/backoff-2.2.1[${PYTHON_USEDEP}]
			>=dev-python/pexpect-4.8.0[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests pytest

# - integration tests require an application key and id (which is reasonable)
# - sync tests require network access
python_test() {
	epytest \
		--deselect test/integration/test_autocomplete.py::test_autocomplete_b2_bucket_n_file_name \
		--deselect test/integration/test_autocomplete.py::test_autocomplete_b2_commands \
		--deselect test/integration/test_autocomplete.py::test_autocomplete_b2_only_matching_commands \
		--deselect test/integration/test_b2_command_line.py::test_integration \
		--deselect test/integration/test_b2_command_line.py::test_download \
		--deselect test/integration/test_b2_command_line.py::test_basic \
		--deselect test/integration/test_b2_command_line.py::test_bucket \
		--deselect test/integration/test_b2_command_line.py::test_key_restrictions \
		--deselect test/integration/test_b2_command_line.py::test_account \
		--deselect test/integration/test_b2_command_line.py::test_sync_up \
		--deselect test/integration/test_b2_command_line.py::test_sync_up_sse_b2 \
		--deselect test/integration/test_b2_command_line.py::test_sync_up_sse_c \
		--deselect test/integration/test_b2_command_line.py::test_sync_up_no_prefix \
		--deselect test/integration/test_b2_command_line.py::test_sync_down \
		--deselect test/integration/test_b2_command_line.py::test_sync_down_no_prefix \
		--deselect test/integration/test_b2_command_line.py::test_sync_down_sse_c_no_prefix \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy_no_prefix_default_encryption \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy_no_prefix_no_encryption \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy_no_prefix_sse_b2 \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy_no_prefix_sse_c \
		--deselect test/integration/test_b2_command_line.py::test_sync_copy_sse_c_single_bucket \
		--deselect test/integration/test_b2_command_line.py::test_sync_long_path \
		--deselect test/integration/test_b2_command_line.py::test_default_sse_b2 \
		--deselect test/integration/test_b2_command_line.py::test_sse_b2 \
		--deselect test/integration/test_b2_command_line.py::test_sse_c \
		--deselect test/integration/test_b2_command_line.py::test_license[True] \
		--deselect test/integration/test_b2_command_line.py::test_license[False] \
		--deselect test/integration/test_b2_command_line.py::test_file_lock \
		--deselect test/integration/test_b2_command_line.py::test_profile_switch \
		--deselect test/integration/test_b2_command_line.py::test_replication_basic \
		--deselect test/integration/test_b2_command_line.py::test_replication_setup \
		--deselect test/integration/test_b2_command_line.py::test_replication_monitoring \
		--deselect test/integration/test_b2_command_line.py::test_enable_file_lock_first_retention_second \
		--deselect test/integration/test_b2_command_line.py::test_enable_file_lock_and_set_retention_at_once \
		--deselect test/integration/test_b2_command_line.py::test_cut \
		--deselect test/unit/test_console_tool.py::TestConsoleTool::test_sync_exclude_if_modified_after_exact \
		--deselect test/unit/test_console_tool.py::TestConsoleTool::test_sync_exclude_if_modified_after_in_range
}

pkg_postinst() {
	elog "The b2 executable has been renamed to backblaze2 in order to"
	elog "avoid a name clash with b2 from boost-build"
}
