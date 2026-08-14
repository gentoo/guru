# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Easily add autocomplete dropdowns to your Textual apps"
HOMEPAGE="
	https://github.com/darrenburns/textual-autocomplete
	https://pypi.org/project/textual-autocomplete/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/textual-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.5.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=(
	pytest-{asyncio,textual-snapshot}
	syrupy
)
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Tests fail but appear visually indistinguishable in snapshot_report.html (v4.0.6)
	# A closer look reveals differing CSS class names
	# TODO Investigate root cause
	tests/snapshots/test_cursor_tracking.py::test_dropdown_tracks_input_cursor_and_cursor_prefix_as_search_string
	tests/snapshots/test_cursor_tracking.py::test_dropdown_tracks_input_cursor_on_click_and_cursor_prefix_search_string
)
