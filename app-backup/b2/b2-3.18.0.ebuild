# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517="pdm-backend"
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Command-line tool for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/B2_Command_Line_Tool"
SRC_URI="https://github.com/Backblaze/B2_Command_Line_Tool/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/B2_Command_Line_Tool-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${P}-nameclash.patch"
)

export PDM_BUILD_SCM_VERSION=${PV}

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/argcomplete-2.1.2[${PYTHON_USEDEP}]
		>=dev-python/arrow-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/b2sdk-1.21.0[${PYTHON_USEDEP}]
		>=dev-python/docutils-0.19[${PYTHON_USEDEP}]
		>=dev-python/phx-class-registry-4.0.6[${PYTHON_USEDEP}]
		>=dev-python/rst2ansi-0.1.5[${PYTHON_USEDEP}]
		>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.65.0[${PYTHON_USEDEP}]
	')
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

EPYTEST_DESELECT=(
	# fixture 'worker_id' not found
	"test/integration/test_b2_command_line.py"
	"test/integration/test_help.py::test_help"
	"test/integration/test_autocomplete.py"

	# Timeout exceeded
	# I think this is trying to access files outside of the sandbox
	"test/unit/console_tool/test_install_autocomplete.py::test_install_autocomplete"

	# TypeError: super(type, obj): obj must be an instance or subtype of type
	# This test itself does not fail, but running it causes subsequent test to
	# fail, which otherwise pass. Not really sure why (I assume this test is
	# somehow polluting the test fixture?) but disabling causes the other tests
	# to pass
	"test/unit/_cli/test_autocomplete_cache.py"
)

pkg_postinst() {
	elog "The b2 executable has been renamed to backblaze2 in order to"
	elog "avoid a name clash with b2 from boost-build"
}
