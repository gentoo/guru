# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Pure config for a stealth Firefox profile"
HOMEPAGE="https://github.com/feder-cr/invisible_core"
SRC_URI="https://github.com/feder-cr/invisible_core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/invisible_core-${PV}"

# They ship some code from the Playwright's Python package
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/maxminddb[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-vcs/git
		net-libs/nodejs

		dev-python/responses[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	"tests/test_e2e_run_ends_with_a_verdict.py::test_a_test_that_hangs_ends_the_run_red_with_its_name_and_its_stack"
	"tests/test_e2e_run_gives_timed_tests_the_machine_alone.py::test_a_client_with_no_timed_test_is_not_red_for_it"
	"tests/test_e2e_run_gives_timed_tests_the_machine_alone.py::test_a_red_timed_test_is_a_red_run"
	"tests/test_e2e_run_gives_timed_tests_the_machine_alone.py::test_the_timed_test_starts_after_the_last_parallel_one_has_ended"
	"tests/test_english.py::test_the_green_says_what_it_looked_at"
	"tests/test_english.py::test_the_root_is_an_argument_so_there_is_nothing_to_refuse"
	"tests/test_english.py::test_this_repository_is_silent_under_its_own_gate"
	"tests/test_marker_vocabulary.py::test_no_string_LITERAL_evaluates_to_a_control_character"
)

EPYTEST_PLUGINS=( pytest-rerunfailures pytest-timeout pytest-xdist )
distutils_enable_tests pytest
