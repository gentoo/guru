# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="
	https://gofastmcp.com/
	https://github.com/PrefectHQ/fastmcp
	https://pypi.org/project/fastmcp/
"
SRC_URI="
	https://github.com/PrefectHQ/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# email-validator via pydantic[email]
BASE_DEPS="
	dev-python/email-validator[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
"

MCP_DEPS="
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-1.0.1[${PYTHON_USEDEP}]
"

# >=aiofile-3.5.0, >=anyio-4.4.0 via py-key-value-aio[filetree]
# >=keyring-25.6.0 via py-key-value-aio[keyring]
# >=cachetools-5.0.0 via py-key-value-aio[memory]
CLIENT_DEPS="
	${MCP_DEPS}
	>=dev-python/aiofile-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/authlib-1.6.11[${PYTHON_USEDEP}]
	>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.6.0[${PYTHON_USEDEP}]
	>=dev-python/py-key-value-aio-0.4.4[${PYTHON_USEDEP}]
"

# py-key-value-aio[filetree,keyring,memory] from CLIENT_DEPS
SERVER_DEPS="
	${MCP_DEPS}
	>=dev-python/authlib-1.6.11[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/griffelib-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/joserfc-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonref-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-path-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.26[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/uncalled-for-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.35[${PYTHON_USEDEP}]
	>=dev-python/watchfiles-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
"

RDEPEND="
	${BASE_DEPS}
	${CLIENT_DEPS}
	${SERVER_DEPS}
"

# TODO fastmcp[anthropic,apps,azure,code-mode,gemini,openai,tasks]
#      missing: [azure,code-mode,gemini]
# TODO pydantic-monty==0.0.17
BDEPEND="
	>=dev-python/uv-dynamic-versioning-0.7.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/anthropic-0.48.0[${PYTHON_USEDEP}]
		>=dev-python/dirty-equals-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/fastapi-0.115.12[${PYTHON_USEDEP}]
		>=dev-python/openai-1.102.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.39.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-sdk-1.20.0[${PYTHON_USEDEP}]
		>=dev-python/prefab-ui-0.18.0[${PYTHON_USEDEP}]
		>=dev-python/psutil-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/pydocket-0.20.0[${PYTHON_USEDEP}]
	)
"

# raise default timeout
# https://bugs.gentoo.org/978150
: ${EPYTEST_TIMEOUT:=10}
EPYTEST_PLUGINS=(
	inline-snapshot
	pytest-{asyncio,env,httpx,timeout}
)
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# raise timeouts for slower CI systems
	# https://bugs.gentoo.org/977930
	sed -i -e 's/@pytest.mark.timeout(15)/@pytest.mark.timeout(60)/' \
		tests/client/test_stdio.py || die
	sed -i -e 's/INIT_TIMEOUT = 3/INIT_TIMEOUT = 10/' \
		tests/client/test_stdio.py || die
}

python_compile() {
	local -x UV_DYNAMIC_VERSIONING_BYPASS=${PV}
	for d in fastmcp_{slim,remote}; do
		pushd ${d} >/dev/null || die
		distutils-r1_python_compile
		popd >/dev/null || die
	done
}

python_test() {
	local EPYTEST_IGNORE=(
		# requires pytest-examples
		tests/docs/test_doc_examples.py

		# requires pydantic-monty
		tests/experimental/transforms/test_code_mode.py

		# require network
		tests/client/transports/test_uv_transport.py
		tests/server/providers/openapi/test_openapi_performance.py

		# requires npm package @modelcontextprotocol/conformance@latest
		tests/conformance/test_conformance.py
	)
	local EPYTEST_DESELECT=()

	if [[ ${EPYTHON} == python3.14 ]]; then
		EPYTEST_DESELECT+=(
			# fails on Python 3.14 due to changes in functools.partial type hint resolution
			tests/server/tasks/test_task_tools.py::test_resolve_param_hints_handles_partials
		)
	fi

	rm -rf fastmcp_{slim,remote} || die
	epytest
}
