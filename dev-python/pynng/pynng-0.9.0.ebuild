# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Ergonomic bindings for nanomsg next generation (nng) in Python"
HOMEPAGE="https://github.com/codypiersall/pynng https://pypi.org/project/pynng"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

# pynng 0.9.0 bundles nng and mbedtls, building them from source via cmake
RDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-build/cmake
	dev-build/ninja
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/sniffio[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	# Fix bundled mbedtls build failure with GCC 15:
	# -Werror=unterminated-string-initialization on unsigned char arrays
	sed -i 's/-Wno-error=array-bounds/-Wno-error=array-bounds -Wno-error=unterminated-string-initialization/' \
		setup.py || die
	distutils-r1_src_prepare
}

python_test() {
	# Remove source pynng directory to avoid import conflicts
	# Tests must run against the installed C extension module
	rm -rf pynng || die
	epytest
}
