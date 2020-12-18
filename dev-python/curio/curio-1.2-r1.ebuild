# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Curio is a coroutine-based library for concurrent systems programming"
HOMEPAGE="
	https://github.com/dabeaz/curio
	https://pypi.org/project/curio
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

IUSE="examples"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="test? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

distutils_enable_sphinx docs --no-autodoc
distutils_enable_tests pytest

python_test() {
	pytest -vv \
			--deselect tests/test_network.py::test_ssl_outgoing \
			--deselect tests/test_queue.py::test_uqueue_asyncio_consumer \
			--deselect tests/test_sync.py::TestUniversalEvent::test_uevent_get_asyncio_set \
			--deselect tests/test_sync.py::TestUniversalEvent::test_uevent_get_asyncio_wait \
			--deselect tests/test_socket.py::test_tcp_echo \
			--deselect tests/test_io.py::test_sendall_cancel \
			|| die
}

python_install_all() {
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
