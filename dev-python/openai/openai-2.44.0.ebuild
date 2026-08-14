# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

# See https://github.com/openai/openai-python/blob/main/.stats.yml
STAINLESS_SPEC_PATH=${PN}/${PN}-b5b621065906a2579dc180db1236ee3b08a4fca9539accc2fbbf88da0ca3923f.yml
# See https://github.com/openai/openai-python/blob/main/scripts/mock
STAINLESS_MOCK_SERVER_VERSION=0.22.1
STAINLESS_MOCK_SERVER_PACKAGE_JSON="${FILESDIR}/${PN}-2.44.0-mock-server-package.json"

inherit distutils-r1 stainless-python

MY_PN="openai-python"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The official Python library for the openai API"
HOMEPAGE="
	https://github.com/openai/openai-python
	https://pypi.org/project/openai/
"
SRC_URI+="
	https://github.com/openai/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/anyio-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		>=dev-python/botocore-1.42.97[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/httpx-aiohttp[${PYTHON_USEDEP}]
		>=dev-python/importlib-metadata-6.7.0[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-4.23.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	inline-snapshot
	nest-asyncio
	pytest-{asyncio,xdist}
	respx
	time-machine
)
distutils_enable_tests pytest
