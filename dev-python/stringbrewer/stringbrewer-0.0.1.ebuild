# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Generate random strings matching a pattern"
HOMEPAGE="https://github.com/simoncozens/stringbrewer"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/sre_yield[${PYTHON_USEDEP}]
	dev-python/rstr[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
