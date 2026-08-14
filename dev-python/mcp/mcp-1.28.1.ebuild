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

# >=cryptography-3.4.0 via pywt[crypto] (>=pyjwt-2.10.1)
RDEPEND="
	>=dev-python/anyio-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.1[${PYTHON_USEDEP}]
	>=dev-python/httpx-sse-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.20.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/typer-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9.0[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/sse-starlette-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.48.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.31.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/dirty-equals-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
		>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( anyio inline-snapshot )
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# Fix TOCTOU port assignment issue
	# https://bugs.gentoo.org/979158
	cat >> tests/conftest.py <<-EOF || die

		def pytest_collection_modifyitems(items):
		    for item in items:
		        if hasattr(item.module, "server_port"):
		            item.add_marker(pytest.mark.xdist_group(name="toctou_fix"))
	EOF
}

python_test() {
	local EPYTEST_IGNORE=(
		# Requires dev-python/pytest-examples which depends on missing Python
		# bindings in dev-util/ruff::gentoo
		tests/test_examples.py
	)
	local EPYTEST_DESELECT=(
		# Runs dev-python/uv and requires network access (v1.28.1)
		tests/client/test_config.py::test_command_execution
	)

	epytest -m "xdist_group" --collect-only
	epytest --dist=loadgroup
}

pkg_postinst() {
	optfeature "colorized log output" dev-python/rich
	optfeature "WebSockets support" dev-python/websockets
}
