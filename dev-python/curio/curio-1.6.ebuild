# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Curio is a coroutine-based library for concurrent systems programming"
HOMEPAGE="
	https://github.com/dabeaz/curio
	https://pypi.org/project/curio/
"

IUSE="examples"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="test? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

EPYTEST_DESELECT=(
	# Needs net
	"tests/test_network.py::test_ssl_outgoing"
)

distutils_enable_sphinx docs --no-autodoc
distutils_enable_tests pytest
