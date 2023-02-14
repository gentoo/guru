# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="A protocol neutral RPC library that supports JSON-RPC and zmq"
HOMEPAGE="
	https://pypi.org/project/tinyrpc/
	https://github.com/mbr/tinyrpc
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# no tests in v1.1.5 tarball
RESTRICT="test"

RDEPEND=">=dev-python/six-1.16.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/jsonext[${PYTHON_USEDEP}]
		>=dev-python/msgpack-1.0.2[${PYTHON_USEDEP}]
		>=dev-python/pika-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/pyzmq-22.0.3[${PYTHON_USEDEP}]
		>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}]
		>=dev-python/werkzeug-2.0.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# needs masked dev-python/gevent
	tests/test_wsgi_transport.py
)

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

pkg_postinst() {
	optfeature "httpclient support" "dev-python/requests dev-python/websocket-client dev-python/gevent-websocket"
	optfeature "wsgi support" dev-python/werkzeug
	optfeature "zmq support" dev-python/pyzmq
	optfeature "jsonext support" dev-python/jsonext
}
