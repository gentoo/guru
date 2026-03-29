# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/modelcontextprotocol/python-sdk
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Model Context Protocol SDK"
HOMEPAGE="
	https://modelcontextprotocol.io/
	https://github.com/modelcontextprotocol/python-sdk
	https://pypi.org/project/mcp/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cli"
REQUIRED_USE="test? ( cli )"

RDEPEND="
	>=dev-python/anyio-4.9.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.1[${PYTHON_USEDEP}]
	>=dev-python/httpx-sse-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.20.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/sse-starlette-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.27.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.31.1[${PYTHON_USEDEP}]
	cli? (
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/typer-0.16.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
		>=dev-python/typer-0.16.0[${PYTHON_USEDEP}]
		>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( anyio )
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Requires dev-python/pytest-examples which depends on missing Python
	# bindings in dev-util/ruff::gentoo
	tests/test_examples.py
)
EPYTEST_DESELECT=(
	# TODO Tests have changed significantly/moved in master; re-check on vbump
	# Fails due to changes in schema generation in newer Pydantic versions (v1.26.0)
	tests/server/fastmcp/test_func_metadata.py::test_structured_output_unserializable_type_error
	# Runs dev-python/uv and requires network access (v1.26.0)
	tests/client/test_config.py::test_command_execution
	# Fails for an unknown reason (wrong response type) (v1.26.0)
	tests/shared/test_streamable_http.py::test_json_response
)

pkg_postinst() {
	optfeature "colorized log output" dev-python/rich
	optfeature "WebSockets support" dev-python/websockets
}

python_test() {
	epytest -o asyncio_mode=auto
}
