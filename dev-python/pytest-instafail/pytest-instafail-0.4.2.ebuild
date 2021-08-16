# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="Plugin for pytest that shows failures and errors instantly"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-instafail
	https://pypi.org/project/pytest-instafail
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND=">=dev-python/pytest-2.9[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pexpect[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	epytest --deselect test_instafail.py::TestInstafailingTerminalReporter::test_print_stacktrace_once_with_pdb
}
