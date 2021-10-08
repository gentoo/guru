# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
DOCS_BUILDER="sphinx"
DOCS_DEPEND="
	dev-python/sphinxcontrib-napoleon
	dev-python/pydata-sphinx-theme
"
DOCS_DIR="${S}/docs"
EPYTEST_DESELECT=( tests/trio/test_keep_alive.py::test_http1_keep_alive_pre_request )
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 docs optfeature

DESCRIPTION="ASGI Server based on Hyper libraries and inspired by Gunicorn"
HOMEPAGE="
	https://pgjones.gitlab.io/hypercorn
	https://gitlab.com/pgjones/hypercorn
	https://github.com/pgjones/hypercorn
	https://pypi.org/project/Hypercorn
"
SRC_URI="https://github.com/pgjones/hypercorn/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/h11[${PYTHON_USEDEP}]
	>=dev-python/h2-3.1.0[${PYTHON_USEDEP}]
	dev-python/priority[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		>=dev-python/mock-4[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-no-coverage.patch" )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "asyncio event loop on top of libuv" dev-python/uvloop
	optfeature "websockets support using wsproto" dev-python/wsproto
	optfeature "websockets support using websockets" dev-python/websockets
	optfeature "httpstools package for http protocol" dev-python/httptools
	optfeature "efficient debug reload" dev-python/watchgod
}
