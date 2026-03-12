# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="A library for working with web frameworks"
HOMEPAGE="
	https://github.com/usecross/cross-web/
	https://pypi.org/project/cross-web/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/typing-extensions-4.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/aiohttp-3.9[${PYTHON_USEDEP}]
		>=dev-python/django-4.2[${PYTHON_USEDEP}]
		>=dev-python/fastapi-0.115.12[${PYTHON_USEDEP}]
		>=dev-python/flask-2.3[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
		>=dev-python/python-multipart-0.0.20[${PYTHON_USEDEP}]
		>=dev-python/quart-0.19[${PYTHON_USEDEP}]
		>=dev-python/starlette-0.46.1[${PYTHON_USEDEP}]
		>=dev-python/werkzeug-2.3[${PYTHON_USEDEP}]
		>=dev-python/yarl-1.9[${PYTHON_USEDEP}]
		>=dev-python/chalice-1.20[${PYTHON_USEDEP}]
		>=dev-python/litestar-2.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# avoid unpackaged test dependencies
	tests/request/test_sanic.py
)
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
