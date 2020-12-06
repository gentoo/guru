# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

DOCBUILDER="sphinx"
DOCDEPEND="
	dev-python/sphinxcontrib-napoleon
	dev-python/pydata-sphinx-theme
"
DOCDIR="${S}/docs"

inherit distutils-r1 docs optfeature

DESCRIPTION="ASGI Server based on Hyper libraries and inspired by Gunicorn"
HOMEPAGE="
	https://gitlab.com/pgjones/hypercorn
	https://github.com/pgjones/hypercorn
	https://pypi.org/project/Hypercorn
"
SRC_URI="https://github.com/pgjones/hypercorn/archive/${PV}.zip -> ${P}.zip"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT=""
RDEPEND="
	dev-python/h11[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-3.1.0[${PYTHON_USEDEP}]
	dev-python/priority[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.14.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_7)
"
BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		>=dev-python/mock-4[${PYTHON_USEDEP}]
		<dev-python/pytest-6[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

#python_prepare_all() {
#	# do not install LICENSE to /usr/
#	sed -i -e '/data_files/d' setup.py || die
#
#	# Remove pytest-cov dep
#	sed -i -e '21,22d' setup.cfg || die
#
#	distutils-r1_python_prepare_all
#}

#pkg_postinst() {
#	optfeature "asyncio event loop on top of libuv" dev-python/uvloop
#	optfeature "websockets support using wsproto" dev-python/wsproto
#	optfeature "websockets support using websockets" dev-python/websockets
#	optfeature "httpstools package for http protocol" dev-python/httptools
#	optfeature "efficient debug reload" dev-python/watchgod
#}

#python_test() {
#	pytest -vv \
#			--deselect tests/protocols/test_http.py::test_supported_upgrade_request[H11Protocol] \
#			--deselect tests/protocols/test_http.py::test_supported_upgrade_request[HttpToolsProtocol] \
#			--deselect tests/protocols/test_websocket.py::test_invalid_upgrade[WSProtocol] \
#	|| die
#}
