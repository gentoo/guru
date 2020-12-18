# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="unittest subTest() support and subtests fixture"
HOMEPAGE="https://github.com/pytest-dev/pytest-subtests"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	>=dev-python/pytest-4.4[${PYTHON_USEDEP}]
	>=dev-python/pytest-xdist-1.28[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	# tests fail if package is not installed
	# workaround is to add source to PYTHONPATH
	PYTHONPATH="${S}"
	pytest -vv || die
}
