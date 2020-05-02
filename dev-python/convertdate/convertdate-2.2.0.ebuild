# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Utils for converting between date formats and calculating holidays"
HOMEPAGE="https://github.com/fitnr/convertdate"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pymeeus[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
"
