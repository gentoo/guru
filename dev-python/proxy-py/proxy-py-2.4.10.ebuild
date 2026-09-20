# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python proxy framework"
HOMEPAGE="https://github.com/abhinavsingh/proxy.py"
SRC_URI="https://github.com/abhinavsingh/proxy.py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/proxy.py-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	sed -e '/--cov/d' \
		-e '/--no-cov-on-fail/d' \
		-e '/--strict-markers/d' \
		-e '/-p pytest_cov/d' \
		-i pytest.ini || die

	sed -e 's/proxy = p/proxy-py = p/' \
		-i setup.cfg || die

	distutils-r1_python_prepare_all
}

EPYTEST_DESELECT=(
	tests/http/proxy/test_http2.py::TestHttp2WithProxy::test_http2_via_proxy
	tests/http/proxy/test_http_proxy.py::TestHttpProxyPlugin::test_proxy_plugin_before_upstream_connection_can_teardown
	tests/http/proxy/test_http_proxy.py::TestHttpProxyPlugin::test_proxy_plugin_on_and_before_upstream_connection
	tests/http/test_client.py::TestClient::test_client
	tests/http/test_client.py::TestClient::test_http
	tests/http/web/test_web_server.py::TestStaticWebServerPlugin::test_static_web_server_serves
	tests/http/web/test_web_server.py::TestStaticWebServerPlugin::test_static_web_server_serves_404
	tests/http/web/test_web_server.py::TestWebServerPlugin::test_default_web_server_returns_404
	tests/http/web/test_web_server.py::TestWebServerPluginWithPacFilePlugin::test_pac_file_served_from_disk
	tests/integration/test_integration.py::test_https_integration
	tests/integration/test_integration.py::test_integration
	tests/integration/test_integration.py::test_modify_chunk_response_integration
	tests/integration/test_integration.py::test_modify_post_response_integration
	tests/plugin/test_http_proxy_plugins_with_tls_interception.py::TestHttpProxyPluginExamplesWithTlsInterception::test_man_in_the_middle_plugin
	tests/plugin/test_http_proxy_plugins_with_tls_interception.py::TestHttpProxyPluginExamplesWithTlsInterception::test_modify_post_data_plugin
	tests/test_grout.py::TestGrout::test_grout
	tests/test_main.py::TestProxyContextManager::test_proxy_context_manager
)

EPYTEST_IGNORE=(
	tests/http/exceptions/test_http_proxy_auth_failed.py
	tests/http/test_protocol_handler.py
	tests/plugin/test_http_proxy_plugins.py
)

EPYTEST_PLUGINS=( pytest-asyncio pytest-mock )
distutils_enable_tests pytest
