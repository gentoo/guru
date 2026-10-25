# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Playwright wrapper for a patched Firefox"
HOMEPAGE="https://github.com/feder-cr/invisible_playwright"
SRC_URI="https://github.com/feder-cr/invisible_playwright/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/invisible_playwright-${PV}"

# They ship some code from the Playwright's Python package
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/invisible-core[${PYTHON_USEDEP}]

	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/pyee[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-vcs/git
	)
"

EPYTEST_DESELECT=(
	"tests/test_async_api.py::test_the_async_api_stamps_the_session_token_into_the_browser_env"
	"tests/test_core_pin.py::test_pyproject_declares_the_pin_exactly_once"
	"tests/test_core_pin.py::test_the_declared_pin_is_read_back_out_of_the_installed_metadata"
	"tests/test_core_pin.py::test_the_expected_core_version_is_declared_only_in_pyproject"
	"tests/test_launcher_config.py::test_enter_with_profile_dir_calls_launch_persistent_context"
	"tests/test_launcher_config.py::test_enter_without_profile_dir_calls_launch_not_persistent"
	"tests/test_launcher_config.py::test_persistent_context_user_data_dir_is_created_if_missing"
	"tests/test_launcher_config.py::test_teardown_closes_persistent_context"
	"tests/test_launcher_helpers.py::test_build_env_caller_env_override_wins"
	"tests/test_launcher_helpers.py::test_build_env_injects_webrtc_egress_when_discovered"
	"tests/test_launcher_helpers.py::test_build_env_never_injects_font_env"
	"tests/test_launcher_helpers.py::test_build_env_no_font_keys_when_absent"
	"tests/test_launcher_helpers.py::test_build_env_no_webrtc_keys_without_proxy"
	"tests/test_publish_gate_wiring.py::test_the_gate_recognises_THIS_project_and_not_the_core"
	"tests/test_publish_gate_wiring.py::test_the_pre_push_hook_gates_release_tags"
	"tests/test_the_version_describes_the_code.py::test_a_normal_install_is_not_second_guessed"
	"tests/test_the_version_describes_the_code.py::test_an_editable_install_reports_what_its_tree_says"
	"tests/test_the_version_describes_the_code.py::test_an_editable_tree_is_never_mistaken_for_the_release"
	"tests/test_the_version_describes_the_code.py::test_the_two_facts_stay_separate_and_named"
)

EPYTEST_PLUGINS=( pytest-timeout )
distutils_enable_tests pytest

src_prepare() {
	sed 's/"invisible_core==.*"/"invisible_core"/' -i pyproject.toml || die

	distutils-r1_src_prepare
}
