# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1 optfeature

DESCRIPTION="A protocol neutral RPC library that supports JSON-RPC and zmq."
HOMEPAGE="https://github.com/mbr/tinyrpc"
SRC_URI="https://github.com/mbr/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/gevent-websocket[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/jsonext[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/pika[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

pkg_postinst() {
	optfeature "gevent support" dev-python/gevent
	optfeature "httpclient support" \
		"dev-python/requests dev-python/websocket-client dev-python/gevent-websocket"
	optfeature "websocket support" dev-python/gevent-websocket
	optfeature "wsgi support" dev-python/werkzeug
	optfeature "zmq support" dev-python/pyzmq
	optfeature "jsonext support" dev-python/jsonext
}
