# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Base58 and Base58Check implementation"
HOMEPAGE="
	https://pypi.org/project/base58/
	https://github.com/keis/base58
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? ( dev-python/pyhamcrest[${PYTHON_USEDEP}] )
"

EPYTEST_DESELECT=(
	# need pytest-benchmark
	test_base58.py::test_encode_random
	test_base58.py::test_decode_random
)

distutils_enable_tests pytest
