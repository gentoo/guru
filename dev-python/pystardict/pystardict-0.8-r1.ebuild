# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

MY_PN="PyStarDict"
DESCRIPTION="Library for manipulating StarDict dictionaries from within Python"
HOMEPAGE="
	https://pypi.org/project/PyStarDict/
	https://github.com/lig/pystardict
"
SRC_URI="$(pypi_sdist_url --no-normalize ${MY_PN}) -> ${P}-r1.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
