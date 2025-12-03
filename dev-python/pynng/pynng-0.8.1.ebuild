# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="Ergonomic bindings for nanomsg next generation (nng) in Python"
HOMEPAGE="https://github.com/codypiersall/pynng https://pypi.org/project/pynng"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

DEPEND="dev-libs/nng"
RDEPEND="
	${DEPEND}
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/sniffio[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	# Remove source pynng directory to avoid import conflicts
	# Tests must run against the installed C extension module
	rm -rf pynng || die
	epytest
}
