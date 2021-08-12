# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

UP="PyStarDict"
S="${WORKDIR}/${UP}-${PV}"
DESCRIPTION="Library for manipulating StarDict dictionaries from within Python"
HOMEPAGE="https://github.com/lig/pystardict https://pypi.org/project/PyStarDict/"
SRC_URI="mirror://pypi/${UP:0:1}/${UP}/${UP}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"

DEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""
