# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
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

BDEPEND="
	test? (
		dev-python/pillow[jpeg,${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( )

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	rm setup.cfg || die
}
