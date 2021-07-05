# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Test clients for Sanic"
HOMEPAGE="
	https://pypi.python.org/pypi/sanic-testing
	https://github.com/sanic-org/sanic-testing
"
SRC_URI="https://github.com/sanic-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
		>=dev-python/httpx-0.18[${PYTHON_USEDEP}]
		>=dev-python/websockets-9[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		>=dev-python/sanic-21.3[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
