# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"
DOCS_AUTODOC=1

inherit distutils-r1 docs

DESCRIPTION="A minimal HTTP client"
HOMEPAGE="
	https://github.com/encode/httpcore
	https://pypi.org/project/httpcore
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# httpcore.ConnectError: [Errno 16] Device or resource busy
RESTRICT="test"

RDEPEND="
	>=dev-python/curio-1.4[${PYTHON_USEDEP}]
	<dev-python/h11-1[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-3[${PYTHON_USEDEP}]
	<dev-python/hyper-h2-5[${PYTHON_USEDEP}]
	>=dev-python/sniffio-1[${PYTHON_USEDEP}]
	<dev-python/sniffio-2[${PYTHON_USEDEP}]
	>=dev-python/trio-0.17.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/anyio-2.0.2[${PYTHON_USEDEP}]
		>=dev-python/hypercorn-0.11.1[${PYTHON_USEDEP}]
		>=dev-python/pproxy-2.3.7[${PYTHON_USEDEP}]
		>=dev-python/pytest-trio-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/trustme-0.6.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
