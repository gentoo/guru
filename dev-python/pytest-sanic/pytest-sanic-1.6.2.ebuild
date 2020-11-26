# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="a Pytest Plugin for Sanic"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-sanic
	https://github.com/yunstanford/pytest-sanic
"
SRC_URI="https://github.com/yunstanford/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/async_generator[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/sanic[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
# where is the conf.py file? make html can't find it either
#distutils_enable_sphinx docs

python_test() {
	distutils_install_for_testing
	pytest -vv || die "Tests failed with ${EPYTHON}"
}
