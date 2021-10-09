# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Plugin to check import ordering using isort"
HOMEPAGE="https://github.com/moccu/pytest-isort"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest

RDEPEND="
	>=dev-python/pytest-3.5[${PYTHON_USEDEP}]
	>=dev-python/isort-4.0[${PYTHON_USEDEP}]
"
