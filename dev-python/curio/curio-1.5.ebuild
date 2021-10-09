# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=bdepend

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

python_prepare_all() {
	# requires internet connection
	sed -i -e 's:test_ssl_outgoing:_&:' \
		tests/test_network.py || die

	# AttributeError: module 'asyncio' has no attribute 'run'
	sed -i -e 's:test_uqueue_asyncio_consumer:_&:' \
		tests/test_queue.py || die
	sed -i -e 's:test_uevent_get_asyncio_set:_&:' \
		-e 's:test_uevent_get_asyncio_wait:_&:' \
		-e 's:test_universal_error:_&:' \
		-e 's:test_universal_value:_&:' \
		tests/test_sync.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
