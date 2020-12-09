# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A Cython interface to the hidapi"
HOMEPAGE="https://github.com/trezor/cython-hidapi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 )"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-libs/hidapi
"

distutils_enable_tests pytest

python_test() {
	pytest -vv tests.py || die "Tests failed with ${EPYTHON}"
}
