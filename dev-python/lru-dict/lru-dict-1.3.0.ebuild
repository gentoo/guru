# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Dict like LRU container"
HOMEPAGE="
	https://pypi.org/project/lru-dict/
	https://github.com/amitdev/lru-dict
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

python_test() {
	cd "${T}" || die
	eunittest "${S}"/test
}
