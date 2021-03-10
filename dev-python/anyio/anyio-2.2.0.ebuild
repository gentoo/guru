# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

# Build with USE="-doc" first because of circular dependency
# otherwise one gets the error that sphinx-autodoc-typehints

DOCS_BUILDER="sphinx"
DOCS_DIR="docs"
DOCS_AUTODOC=1

inherit distutils-r1 docs

DESCRIPTION="Compatibility layer for multiple asynchronous event loop implementations"
HOMEPAGE="
	https://github.com/agronholm/anyio
	https://pypi.org/project/anyio
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/curio-1.4[${PYTHON_USEDEP}]
	>=dev-python/idna-2.8[${PYTHON_USEDEP}]
	>=dev-python/sniffio-1.1[${PYTHON_USEDEP}]
	>=dev-python/trio-0.16[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_7)
"

BDEPEND="
	${RDEPEND}
	doc? (
		dev-python/anyio[${PYTHON_USEDEP}]
		>=dev-python/sphinx-autodoc-typehints-1.2.0[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	)
	test? (
		>=dev-python/hypothesis-4.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.0[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		>=dev-python/uvloop-0.15[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	pytest -vv \
			--deselect tests/test_sockets.py::test_getaddrinfo[asyncio] \
			--deselect tests/test_sockets.py::test_getaddrinfo[asyncio+uvloop] \
			--deselect tests/test_sockets.py::test_getaddrinfo[curio] \
			--deselect tests/test_sockets.py::test_getaddrinfo[trio] \
	|| die
}
