# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Pure-Python implementation of the blurhash algorithm"
HOMEPAGE="
	https://pypi.org/project/blurhash/
	https://github.com/halcy/blurhash-python
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# no tests in v1.1.4 tarball
RESTRICT="test"

BDEPEND="
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	rm setup.cfg || die
}
