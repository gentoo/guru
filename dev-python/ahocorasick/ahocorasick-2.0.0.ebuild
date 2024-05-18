# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{8..12} )
PYPI_PN="py${PN}"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Python module implementing Aho-Corasick algorithm"
HOMEPAGE="https://github.com/WojciechMula/pyahocorasick"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest
