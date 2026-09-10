# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="
	https://textual.textualize.io/
	https://github.com/Textualize/textual
	https://pypi.org/project/textual/
"
SRC_URI="https://github.com/Textualize/textual/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/markdown-it-py-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-3.6.0[${PYTHON_USEDEP}]
	<dev-python/platformdirs-5[${PYTHON_USEDEP}]
	>=dev-python/rich-14.2.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.4.0[${PYTHON_USEDEP}]
	<dev-python/typing-extensions-5[${PYTHON_USEDEP}]
"

declare -A SYNTAX_LANGS=(
	["bash"]="Bash"
	["c"]="C"
	# TODO Missing keyword for ~arm64 in ::gentoo
	#["cmake"]="CMake"
	["cpp"]="C++"
	["html"]="HTML"
	["javascript"]="JavaScript"
	["json"]="JSON"
	["lua"]="Lua"
	# TODO No Python bindings in ::gentoo
	#["markdown"]="Markdown"
	["python"]="Python"
	# TODO Missing keyword for ~arm64 in ::gentoo
	#["ruby"]="Ruby"
	["rust"]="Rust"
	# TODO Many other (common) languages are neither in ::gentoo nor ::guru
)

BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		=dev-python/textual-dev-1.8*[${PYTHON_USEDEP}]
		$(printf " dev-libs/tree-sitter-%s[python,${PYTHON_USEDEP}]" "${!SYNTAX_LANGS[@]}")
	)
"

DOCS+=( {CHANGELOG,README}.md )

EPYTEST_PLUGINS=(
	syrupy
	pytest-{asyncio,textual-snapshot}
)
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Require unavailable tree-sitter-*[python] grammar packages (v8.1.1)
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[markdown]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[toml]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[yaml]"
	"tests/text_area/test_languages.py::test_setting_builtin_language_via_constructor" # markdown
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[css]"
	"tests/text_area/test_languages.py::test_setting_builtin_language_via_attribute" # markdown
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[go]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[regex]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[sql]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[java]"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_language_rendering[xml]"

	# These tests do not render correctly per visual inspection of snapshot_report.html (v8.1.1)
	# TODO Investigate/ask upstream
	"tests/snapshot_tests/test_snapshots.py::test_richlog_width"
	"tests/snapshot_tests/test_snapshots.py::test_richlog_min_width"
	"tests/snapshot_tests/test_snapshots.py::test_richlog_deferred_render_expand"
	"tests/snapshot_tests/test_snapshots.py::test_welcome"
	"tests/snapshot_tests/test_snapshots.py::test_text_area_wrapping_and_folding"

	# Likely missed in this PR: (v8.1.1)
	# https://github.com/Textualize/textual/pull/6410#issuecomment-4135017177
	"tests/test_arrange.py::test_arrange_dock_left"
)

python_test() {
	# Tests use @pytest.mark.xdist_group
	epytest --dist loadgroup
}

pkg_postinst() {
	optfeature_header "Install additional packages for syntax highlighting:"

	local lang
	for lang in "${!SYNTAX_LANGS[@]}"; do
		optfeature "${SYNTAX_LANGS[${lang}]}" "dev-libs/tree-sitter-${lang}[python]"
	done
}
