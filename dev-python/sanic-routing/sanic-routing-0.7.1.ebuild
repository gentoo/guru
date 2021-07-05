# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Internal handler routing for Sanic"
HOMEPAGE="
	https://pypi.python.org/pypi/sanic-routing
	https://github.com/sanic-org/sanic-routing
"
SRC_URI="https://github.com/sanic-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/sanic[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
