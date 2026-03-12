# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 #pypi

DESCRIPTION="Light, flexible and extensible ASGI framework"
HOMEPAGE="
	https://github.com/litestar-org/litestar/
	https://pypi.org/project/litestar/
"
# no tests in sdist
SRC_URI="
	https://github.com/litestar-org/litestar/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/anyio-3[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.22[${PYTHON_USEDEP}]
	>=dev-python/litestar-htmx-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/msgspec-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/multidict-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/multipart-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/polyfactory-2.6.3[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0.0[${PYTHON_USEDEP}]
	dev-python/rich-click[${PYTHON_USEDEP}]
	>=dev-python/sniffio-1.3.1[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		>=dev-python/asyncpg-0.29.0[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]
		dev-python/httpx-sse[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/hypercorn[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/prometheus-client[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/psycopg:0[${PYTHON_USEDEP}]
		dev-python/pydantic-extra-types[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/structlog[${PYTHON_USEDEP}]
		<dev-python/time-machine-3[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Requires docker
	"tests/unit/test_channels/test_plugin.py"
	"tests/unit/test_testing/test_test_client.py"
	"tests/unit/test_channels/test_backends.py"

	# Unpackaged advanced alchemy
	"tests/examples/test_dto/test_example_apps.py"
	"tests/unit/test_dto/test_factory/test_integration.py"
	"tests/e2e/test_advanced_alchemy.py"
	"tests/examples/test_contrib/test_sqlalchemy/plugins/test_example_apps.py"
	"tests/examples/test_contrib/test_sqlalchemy/plugins/test_tutorial_example_apps.py"
	"tests/examples/test_contrib/test_sqlalchemy/test_sqlalchemy_examples.py"
	"tests/unit/test_app.py"
	"tests/unit/test_contrib/test_sqlalchemy.py"
	"tests/unit/test_plugins/test_base.py"
	"tests/unit/test_plugins/test_sqlalchemy.py"
	"tests/unit/test_repository/test_generic_mock_repository.py"
	"tests/examples/test_plugins/test_sqlalchemy_init_plugin.py"

	# Unpackaged minijinja
	"tests/examples/test_templating/test_engine_instance.py"
	"tests/examples/test_templating/test_returning_templates.py"
	"tests/examples/test_templating/test_template_functions.py"
	"tests/unit/test_contrib/test_minijinja.py"
	"tests/unit/test_plugins/test_flash.py"
	"tests/unit/test_template/test_built_in.py"
	"tests/unit/test_template/test_builtin_functions.py"
	"tests/unit/test_template/test_context.py"
	"tests/unit/test_template/test_csrf_token.py"
	"tests/unit/test_template/test_template.py"

	# Unpackaged beanie
	"tests/unit/test_plugins/test_pydantic/test_beanie_integration.py"

	# Unpackaged valkey
	"tests/unit/test_stores.py"

	# Avoid the dependency
	"tests/unit/test_contrib/test_opentelemetry.py"
	"tests/unit/test_plugins/test_prometheus.py"
)
EPYTEST_DESELECT=(
	# Requires docker
	"tests/e2e/test_response_caching.py::test_with_stores[redis_store]"
	"tests/e2e/test_routing/test_path_resolution.py::test_server_root_path_handling_empty_path[hypercorn]"

	# Unpackaged daphne
	"tests/e2e/test_routing/test_path_resolution.py::test_no_path_traversal_from_static_directory[daphne]"
	"tests/e2e/test_routing/test_path_resolution.py::test_server_root_path_handling_empty_path[daphne]"
	"tests/e2e/test_routing/test_path_resolution.py::test_server_root_path_handling[daphne]"
	"tests/e2e/test_routing/test_path_mounting.py::test_path_mounting_live_server[daphne]"

	# Deprecation test
	"tests/unit/test_deprecations.py::test_contrib_minijnja_deprecation"
	"tests/unit/test_deprecations.py::test_minijinja_from_state_deprecation"

	# Unpackaged advanced alchemy
	"tests/examples/test_data_transfer_objects/test_factory/test_type_checking.py::test_should_raise_error_on_route_registration"
	"tests/unit/test_contrib/test_repository.py::test_advanced_alchemy_imports"

	# Fragile to configuration differences
	"tests/e2e/test_logging/test_structlog_to_file.py::test_structlog_to_file"
	"tests/unit/test_connection/test_request.py::test_request_headers"
	"tests/unit/test_connection/test_websocket.py::test_websocket_headers"

	# Fragile to background load
	#"tests/unit/test_handlers/test_http_handlers/test_kwarg_handling.py::test_route_handler_kwarg_handling"

	# TypeError: Issuer (iss) must be a string.
	"tests/unit/test_security/test_jwt/test_auth.py::test_jwt_auth_validation_error_returns_not_authorized"
)

EPYTEST_RERUNS=5 # upstream does it, and yes flaky is real
EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-asyncio pytest-mock pytest-lazy-fixtures )
distutils_enable_tests pytest

PATCHES=(
	# valkey not packaged
	"${FILESDIR}"/litestar-2.19.0-no-valkey.patch
)

python_test() {
	epytest -o addopts= tests
}
