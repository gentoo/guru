# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

COMMIT="39115c3d061d2f83e4a030bcb8642ec6f3203e61"

DESCRIPTION="A more Pythonic version of doxypy, a Doxygen filter for Python"
HOMEPAGE="https://github.com/Feneric/doxypypy"
SRC_URI="https://github.com/Feneric/doxypypy/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

RESTRICT="!test? ( test )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/zope-interface[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare
	# These files fail to byte-compille (UTF-LE?)
	# ValueError: source code string cannot contain null bytes
	# Matches pypy tarball
	rm doxypypy/test/sample_utf* || die
	sed -i '/test_utf/,+5d' doxypypy/test/test_doxypypy.py || die
}
