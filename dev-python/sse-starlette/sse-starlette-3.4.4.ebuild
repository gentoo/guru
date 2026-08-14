# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Server-Sent Events for Starlette and FastAPI"
HOMEPAGE="
	https://github.com/sysid/sse-starlette/
	https://pypi.org/project/sse-starlette/
"
# test files missing in sdist
SRC_URI+="
	https://github.com/sysid/sse-starlette/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/starlette-0.49.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.7.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/asgi-lifespan-2.1.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.34.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	tests/experimentation
	tests/integration
)
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
