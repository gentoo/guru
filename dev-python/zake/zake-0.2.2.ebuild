# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Provide a nice set of testing utilities for the kazoo library"
HOMEPAGE="
	https://pypi.org/project/zake/
	https://github.com/yahoo/Zake
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/kazoo-1.3.1[${PYTHON_USEDEP}]"
DEPEND="
	${REDEPEND}
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/testtools[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose
