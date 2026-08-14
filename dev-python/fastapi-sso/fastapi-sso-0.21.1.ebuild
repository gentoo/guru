# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="FastAPI plugin to enable SSO to most common providers"
HOMEPAGE="
	https://github.com/tomasvotava/fastapi-sso
	https://pypi.org/project/fastapi-sso/
"
SRC_URI="
	https://github.com/tomasvotava/fastapi-sso/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64" # ~arm64: fastapi

# strictly >=pydantic-1.8.0; raised to 2.0.0 for email-validator-2.0.0
RDEPEND="
	>=dev-python/email-validator-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.80[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/pytest-asyncio-0.24[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.23.1[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed -i -e '/--cov/d' pyproject.toml || die
}
