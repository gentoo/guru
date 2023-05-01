# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Required for test phase
DISTUTILS_IN_SOURCE_BUILD=1
EPYTEST_DESELECT=(
	testrepository/tests/test_repository.py::TestRepositoryContract::test_can_get_inserter
	testrepository/tests/test_repository.py::TestRepositoryContract::test_can_initialise_with_param
	testrepository/tests/test_repository.py::TestRepositoryContract::test_count
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_complete_runs_delete_missing_failures
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_empty
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_get_id
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_get_subunit_stream
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_one_run
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_failing_partial_runs_preserve_missing_failures
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_latest_run
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_latest_run_empty_repo
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_subunit_from_test_run
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_test_from_test_run
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_test_ids
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_test_run
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_test_run_get_id
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_test_run_missing_keyerror
	testrepository/tests/test_repository.py::TestRepositoryContract::test_get_times_unknown_tests_are_unknown
	testrepository/tests/test_repository.py::TestRepositoryContract::test_insert_stream_smoke
	testrepository/tests/test_repository.py::TestRepositoryContract::test_inserted_exists_no_impact_on_test_times
	testrepository/tests/test_repository.py::TestRepositoryContract::test_inserted_test_times_known
	testrepository/tests/test_repository.py::TestRepositoryContract::test_inserting_creates_id
	testrepository/tests/test_repository.py::TestRepositoryContract::test_latest_id_empty
	testrepository/tests/test_repository.py::TestRepositoryContract::test_latest_id_nonempty
	testrepository/tests/test_repository.py::TestRepositoryContract::test_open
	testrepository/tests/test_repository.py::TestRepositoryContract::test_open_non_existent
	testrepository/tests/test_repository.py::TestRepositoryContract::test_unexpected_success
	testrepository/tests/test_ui.py::TestUIContract::test_args_are_exposed_at_arguments
	testrepository/tests/test_ui.py::TestUIContract::test_exec_subprocess
	testrepository/tests/test_ui.py::TestUIContract::test_factory_input_stream_args
	testrepository/tests/test_ui.py::TestUIContract::test_factory_noargs
	testrepository/tests/test_ui.py::TestUIContract::test_here
	testrepository/tests/test_ui.py::TestUIContract::test_iter_streams_load_stdin_use_case
	testrepository/tests/test_ui.py::TestUIContract::test_iter_streams_unexpected_type_raises
	testrepository/tests/test_ui.py::TestUIContract::test_make_result
	testrepository/tests/test_ui.py::TestUIContract::test_make_result_previous_run
	testrepository/tests/test_ui.py::TestUIContract::test_options_at_options
	testrepository/tests/test_ui.py::TestUIContract::test_options_on_command_picked_up
	testrepository/tests/test_ui.py::TestUIContract::test_options_when_set_at_options
	testrepository/tests/test_ui.py::TestUIContract::test_output_error
	testrepository/tests/test_ui.py::TestUIContract::test_output_rest
	testrepository/tests/test_ui.py::TestUIContract::test_output_stream
	testrepository/tests/test_ui.py::TestUIContract::test_output_stream_non_utf8
	testrepository/tests/test_ui.py::TestUIContract::test_output_summary
	testrepository/tests/test_ui.py::TestUIContract::test_output_table
	testrepository/tests/test_ui.py::TestUIContract::test_output_tests
	testrepository/tests/test_ui.py::TestUIContract::test_output_values
	testrepository/tests/test_ui.py::TestUIContract::test_set_command
	testrepository/tests/test_ui.py::TestUIContract::test_set_command_checks_args_invalid_arg
	testrepository/tests/test_ui.py::TestUIContract::test_set_command_checks_args_missing_arg
	testrepository/tests/test_ui.py::TestUIContract::test_set_command_checks_args_unwanted_arg
	testrepository/tests/test_ui.py::TestUIContract::test_set_command_with_no_name_works
	testrepository/tests/test_ui.py::TestUIContract::test_subprocesses_have_stdin
	testrepository/tests/test_ui.py::TestUIContract::test_subprocesses_have_stdout
	testrepository/tests/commands/test_run.py::TestReturnCodeToSubunit::test_returncode_0_no_change
	testrepository/tests/commands/test_run.py::TestReturnCodeToSubunit::test_returncode_nonzero_fail_appended_to_content
	testrepository/tests/ui/test_cli.py::TestCLIUI::test_dash_dash_help_shows_help
)
PYTHON_COMPAT=( python3_10 pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

DESCRIPTION="A repository of test results"
HOMEPAGE="
	https://launchpad.net/testrepository
	https://pypi.org/project/testrepository/
	https://github.com/testing-cabal/testrepository
"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
	>=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
	dev-python/fixtures[${PYTHON_USEDEP}]
"
#bzr is listed but presumably req'd for a live repo test run
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/testresources[${PYTHON_USEDEP}]
		dev-python/testscenarios[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-test-backport.patch"
	"${FILESDIR}/${P}-test-backport1.patch"
	"${FILESDIR}/${P}-test-backport2.patch"
)

distutils_enable_tests pytest
