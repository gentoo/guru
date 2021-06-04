# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Command-line tool for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/B2_Command_Line_Tool"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-2.5.0-nameclash.patch"
	"${FILESDIR}/${PN}-2.5.0-disable-pip-requirement-installs.patch"
)

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/arrow-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/b2sdk-1.8.0[${PYTHON_USEDEP}]
		>=dev-python/phx-class-registry-3.0.5[${PYTHON_USEDEP}]
		>=dev-python/rst2ansi-0.1.5[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		<dev-python/importlib_metadata-3.0.0[${PYTHON_USEDEP}]
		' pypy3 python3_7)
	$(python_gen_cond_dep '
		>=dev-python/importlib_metadata-3.3.0[${PYTHON_USEDEP}]
		' pypy3 python3_8)
"

distutils_enable_tests pytest

python_test() {
	epytest \
		--deselect test/integration/test_b2_command_line.py::test_integration \
		--deselect test/unit/test_arg_parser.py::TestCustomArgTypes::test_parse_millis_from_float_timestamp \
		--deselect test/unit/test_console_tool.py::TestConsoleTool::test_sync_exclude_if_modified_after_exact \
		--deselect test/unit/test_console_tool.py::TestConsoleTool::test_sync_exclude_if_modified_after_in_range
}

pkg_postinst() {
	elog "The b2 executable has been renamed to backblaze2 in order to"
	elog "avoid a name clash with b2 from boost-build"
}
