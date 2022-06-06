# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Manage calls to calloc/free through Cython"
HOMEPAGE="
	https://pypi.org/project/cymem/
	https://github.com/explosion/cymem
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	cd "${T}" || die
	epytest --pyargs ${PN}
}
