# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Plugin for pytest that shows failures and errors instantly"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-instafail
	https://pypi.org/project/pytest-instafail
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pytest-2.9[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	# pexpect.exceptions.EOF: End Of File (EOF). Exception style platform.
	sed -i -e 's:test_print_stacktrace_once_with_pdb:_&:' \
		test_instafail.py  || die

	distutils-r1_python_prepare_all
}

python_test() {
	distutils_install_for_testing
	pytest -vv || die "Testsuite failed under ${EPYTHON}"
}
