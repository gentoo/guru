# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="
	https://gofastmcp.com/
	https://github.com/PrefectHQ/fastmcp
	https://pypi.org/project/fastmcp/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/authlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.115.12[${PYTHON_USEDEP}]
	>=dev-python/griffelib-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/jsonref-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-path-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/py-key-value-aio-0.4.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[${PYTHON_USEDEP}]
	dev-python/email-validator[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/uncalled-for-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.35[${PYTHON_USEDEP}]
	>=dev-python/watchfiles-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/aiofile-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/anthropic-0.48.0[${PYTHON_USEDEP}]
		>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]
		>=dev-python/dirty-equals-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/inline-snapshot-0.27.2[${PYTHON_USEDEP}]
		dev-python/joserfc[${PYTHON_USEDEP}]
		>=dev-python/openai-1.102.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-sdk-1.20.0[${PYTHON_USEDEP}]
		<dev-python/prefab-ui-0.20.0[${PYTHON_USEDEP}]
		>=dev-python/pydocket-0.19.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	inline-snapshot
	pytest-{asyncio,env,httpx,timeout}
)
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TODO These fail because >=pydocket-0.20.0 replaces fakeredis with burner-redis
	tests/server/tasks/test_concurrent_dependencies.py::test_sync_context_functions_work_in_background_without_deps
	tests/server/http/test_http_dependencies.py::test_background_task_can_read_snapshotted_request_headers
	tests/server/http/test_http_dependencies.py::test_background_task_current_http_dependencies_restore_headers
)

EPYTEST_IGNORE=(
	# requires pytest-examples
	tests/docs/test_doc_examples.py

	# requires pydantic-monty
	tests/experimental/transforms/test_code_mode.py

	# requires azure from azure-sdk-for-python
	tests/server/auth/providers/test_azure_scopes.py

	# require network
	tests/client/transports/test_uv_transport.py
	tests/server/providers/openapi/test_openapi_performance.py

	# requires node module @modelcontextprotocol/conformance@latest
	tests/conformance/test_conformance.py
)
