# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

# See https://github.com/anthropics/anthropic-sdk-python/blob/main/.stats.yml
STAINLESS_SPEC_PATH=${PN}/${PN}-506a5ad71d522b4ae56ac3429380486647af1f92eddde80603480fb592d62b54.yml
# See https://github.com/anthropics/anthropic-sdk-python/blob/main/scripts/mock
STAINLESS_MOCK_SERVER_VERSION=0.22.1
STAINLESS_MOCK_SERVER_PACKAGE_JSON="${FILESDIR}/${PN}-0.116.0-mock-server-package.json"

inherit distutils-r1 optfeature stainless-python

MY_PN="anthropic-sdk-python"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The official Python library for the anthropic API"
HOMEPAGE="
	https://github.com/anthropics/anthropic-sdk-python
	https://pypi.org/project/anthropic
"
SRC_URI+="
	https://github.com/anthropics/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/anyio-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		>=dev-python/boto3-1.28.57[${PYTHON_USEDEP}]
		>=dev-python/botocore-1.31.57[${PYTHON_USEDEP}]
		>=dev-python/httpx-aiohttp-0.1.9[${PYTHON_USEDEP}]
		>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
		>=dev-python/standardwebhooks-1.0.1[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	dirty-equals
	http-snapshot
	inline-snapshot
	pytest-{asyncio,xdist}
	respx
	time-machine
)
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "alternative async HTTP client support" \
		"dev-python/aiohttp >=dev-python/httpx-aiohttp-0.1.9"
	optfeature "Google Cloud Vertex AI integration" \
		">=dev-python/google-auth-2 dev-python/requests"
	optfeature "Amazon Web Services (AWS) Bedrock integration" \
		">=dev-python/boto3-1.28.57 >=dev-python/botocore-1.31.57"
	optfeature "Model Context Protocol (MCP) support" \
		">=dev-python/mcp-1.0"
}
