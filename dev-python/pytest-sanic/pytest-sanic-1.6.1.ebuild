# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7} )

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
	dev-python/sanic[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
# where is the conf.py file? make html can't find it either
#distutils_enable_sphinx docs

python_test() {
	# skip this test: Task was destroyed but it is pending!
	pytest -vv --deselect tests/test_client_websocket.py::test_fixture_sanic_client_ws || die "Tests failed with ${EPYTHON}"
}
