# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 optfeature

DESCRIPTION="A protocol neutral RPC library that supports JSON-RPC and zmq"
HOMEPAGE="https://github.com/mbr/tinyrpc"
SRC_URI="https://github.com/mbr/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/six-1.16.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/gevent-websocket-0.10.1[${PYTHON_USEDEP}]
		>=dev-python/gevent-21.1.2[${PYTHON_USEDEP}]
		dev-python/jsonext[${PYTHON_USEDEP}]
		>=dev-python/msgpack-1.0.2[${PYTHON_USEDEP}]
		>=dev-python/pika-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/pyzmq-22.0.3[${PYTHON_USEDEP}]
		>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}]
		>=dev-python/werkzeug-2.0.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

pkg_postinst() {
	optfeature "gevent support" dev-python/gevent
	optfeature "httpclient support" "dev-python/requests dev-python/websocket-client dev-python/gevent-websocket"
	optfeature "websocket support" dev-python/gevent-websocket
	optfeature "wsgi support" dev-python/werkzeug
	optfeature "zmq support" dev-python/pyzmq
	optfeature "jsonext support" dev-python/jsonext
}
