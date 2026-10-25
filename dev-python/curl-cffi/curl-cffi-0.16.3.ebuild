# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python bindings for curl-impersonate"
HOMEPAGE="https://github.com/lexiforest/curl_cffi"
SRC_URI="https://github.com/lexiforest/curl_cffi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/curl_cffi-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-misc/curl-impersonate

	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/litestar[${PYTHON_USEDEP}]
		dev-python/proxy-py[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	export IMPERSONATE_LINK_TYPE="dynamic"
	export IMPERSONATE_BUILD_DIR="${EROOT}/usr/lib64"

	sed -e 's#"curl/curl.h"#"curl-impersonate/curl.h"#' \
		-i ffi/shim.h || die

	sed -e '/^download_libcurl/d' \
		-e "s#str(libdir / \"include\")#\"${EROOT}/usr/include\"#" \
		-i scripts/build.py || die

	distutils-r1_python_prepare_all
}

EPYTEST_DESELECT=(
	"tests/integration/test_real_world.py::test_post_with_no_body"
	"tests/integration/test_response_class.py::test_custom_response"
	"tests/integration/test_response_class.py::test_default_response"
	"tests/pro/test_fp_verify.py::test_live_fingerprint_data_matches_runtime_output"
	"tests/pro/test_fp_verify.py::test_live_http3_fingerprint_data_matches_runtime_output"
	"tests/unittest/test_async.py::test_add_handle"
	"tests/unittest/test_async.py::test_socket_action"
	"tests/unittest/test_async_session.py::test_update_params"
)

EPYTEST_IGNORE=(
	"tests/integration/test_fingerprints.py"
	"tests/integration/test_httpbin.py"
	"tests/threads/test_eventlet.py"
	"tests/threads/test_gevent.py"
	"tests/unittest/test_smoke.py"
	"tests/unittest/test_upload.py"
)

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	cp "${BUILD_DIR}/install$(python_get_sitedir)/curl_cffi/"*.so curl_cffi || die
	epytest
}
