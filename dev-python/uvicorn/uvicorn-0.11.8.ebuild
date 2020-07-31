# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

DISTUTILS_USE_SETUPTOOLS=rdepend

DOCBUILDER="mkdocs"
DOCDEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs eutils

DESCRIPTION="The lightning-fast ASGI server"
HOMEPAGE="https://www.uvicorn.org/
	https://github.com/encode/uvicorn"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
"

DEPEND="test? (
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/uvloop-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-8.0[${PYTHON_USEDEP}]
	dev-python/httptools[${PYTHON_USEDEP}]
	>=dev-python/watchgod-0.6[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "asyncio event loop on top of libuv" dev-python/uvloop
	optfeature "websockets support using wsproto" dev-python/wsproto
	optfeature "websockets support using websockets" dev-python/websockets
	optfeature "httpstools package for http protocol" dev-python/httptools
	optfeature "efficient debug reload" dev-python/watchgod
}
