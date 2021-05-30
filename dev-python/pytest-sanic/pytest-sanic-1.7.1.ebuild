# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="a Pytest Plugin for Sanic"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-sanic
	https://github.com/yunstanford/pytest-sanic
"
SRC_URI="https://github.com/yunstanford/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/async_generator-1.10[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.15.4[${PYTHON_USEDEP}]
	>=dev-python/pytest-5.2[${PYTHON_USEDEP}]
	>=dev-python/websockets-8.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-python/sanic-20.12.2[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
# where is the conf.py file? make html can't find it either
#distutils_enable_sphinx docs

python_test() {
	distutils_install_for_testing
	pytest -vv \
		--deselect tests/test_client.py::test_fixture_sanic_client_get \
		--deselect tests/test_client.py::test_fixture_sanic_client_post \
		--deselect tests/test_client.py::test_fixture_sanic_client_put \
		--deselect tests/test_client.py::test_fixture_sanic_client_delete \
		--deselect tests/test_client.py::test_fixture_sanic_client_patch \
		--deselect tests/test_client.py::test_fixture_sanic_client_options \
		--deselect tests/test_client.py::test_fixture_sanic_client_head \
		--deselect tests/test_client.py::test_fixture_sanic_client_close \
		--deselect tests/test_client.py::test_fixture_sanic_client_passing_headers \
		--deselect tests/test_client.py::test_fixture_sanic_client_context_manager \
		--deselect tests/test_client.py::test_fixture_test_client_context_manager \
		|| die "Tests failed with ${EPYTHON}"

}
