# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
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

BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/cymem-2.0.7-flags.patch )

distutils_enable_tests pytest

python_test() {
	cd "${T}" || die
	epytest --pyargs ${PN}
}
