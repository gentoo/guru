# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Server-Sent Events for Starlette and FastAPI"
HOMEPAGE="
	https://github.com/sysid/sse-starlette/
	https://pypi.org/project/sse-starlette/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/starlette-0.49.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.7.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/asgi-lifespan-2.1.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
		>=dev-python/portend-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/psutil-6.1.1[${PYTHON_USEDEP}]
		>=dev-python/tenacity-9.0.0[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.34.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
