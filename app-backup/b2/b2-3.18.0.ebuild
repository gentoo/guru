# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_10 python3_11 python3_12 )
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

# - integration tests require an application key and id (which is reasonable)
# - sync tests require network access
python_test() {
	epytest --deselect test/unit/console_tool test/unit
	epytest test/unit/console_tool
}

pkg_postinst() {
	elog "The b2 executable has been renamed to backblaze2 in order to"
	elog "avoid a name clash with b2 from boost-build"
}
